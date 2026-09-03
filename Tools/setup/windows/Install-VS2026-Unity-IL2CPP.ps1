#requires -Version 5.1

[CmdletBinding()]
param(
    [switch]$CheckOnly,
    [switch]$NoPause
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$UnityVersion = "6000.3.22f1"
$UnityChangeset = "1c726e1fb402"
$MinimumPython = [version]"3.9"
$MinimumSdk = [version]"10.0.19041.0"
$MinimumFreeGb = 40
$TempFolder = Join-Path $env:TEMP "RootsDance-Windows-Build-Setup"
$script:InstallErrors = New-Object System.Collections.Generic.List[string]
$script:Results = @()
$script:TranscriptStarted = $false

[Console]::InputEncoding = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
$OutputEncoding = [Console]::OutputEncoding

function Write-Title {
    param([string]$Text)
    Write-Host ""
    Write-Host ("=" * 72) -ForegroundColor DarkCyan
    Write-Host $Text -ForegroundColor Cyan
    Write-Host ("=" * 72) -ForegroundColor DarkCyan
}

function Write-Step {
    param([string]$Text)
    Write-Host ""
    Write-Host "[进行中] $Text" -ForegroundColor Yellow
}

function Write-Ok {
    param([string]$Text)
    Write-Host "[通过] $Text" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Text)
    Write-Host "[提醒] $Text" -ForegroundColor Yellow
}

function Wait-BeforeExit {
    if (-not $NoPause) {
        Write-Host ""
        [void](Read-Host "按 Enter 键关闭窗口")
    }
}

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdministrator)) {
    Write-Host "正在请求管理员权限……" -ForegroundColor Yellow
    $arguments = "-NoLogo -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    if ($CheckOnly) {
        $arguments += " -CheckOnly"
    }
    if ($NoPause) {
        $arguments += " -NoPause"
    }

    try {
        $elevated = Start-Process -FilePath (Join-Path $PSHOME "powershell.exe") `
            -Verb RunAs -ArgumentList $arguments -Wait -PassThru
        exit $elevated.ExitCode
    }
    catch {
        Write-Host "无法取得管理员权限：$($_.Exception.Message)" -ForegroundColor Red
        Wait-BeforeExit
        exit 1
    }
}

function Refresh-ProcessPath {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Get-CommandPath {
    param([string]$Name)
    $command = Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($null -eq $command) {
        return $null
    }
    return $command.Source
}

function Get-PythonVersion {
    foreach ($candidate in @("py", "python")) {
        if ($null -eq (Get-CommandPath $candidate)) {
            continue
        }
        try {
            if ($candidate -eq "py") {
                $text = & $candidate -3 -c "import platform; print(platform.python_version())" 2>$null
            }
            else {
                $text = & $candidate -c "import platform; print(platform.python_version())" 2>$null
            }
            if ($LASTEXITCODE -eq 0) {
                return [version](([string]$text).Trim())
            }
        }
        catch {
            continue
        }
    }
    return $null
}

function Get-GitVersion {
    $git = Get-CommandPath "git"
    if ($null -eq $git) {
        return $null
    }
    try {
        $text = & $git --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            return ([string]$text).Trim()
        }
    }
    catch {
        return $null
    }
    return $null
}

function Get-GitLfsVersion {
    $git = Get-CommandPath "git"
    if ($null -eq $git) {
        return $null
    }
    try {
        $text = & $git lfs version 2>$null
        if ($LASTEXITCODE -eq 0) {
            return ([string]$text).Trim()
        }
    }
    catch {
        return $null
    }
    return $null
}

function Download-VerifiedFile {
    param(
        [string]$Uri,
        [string]$Destination,
        [string]$Sha256 = "",
        [string]$PublisherPattern = ""
    )

    Write-Host "  下载：$Uri"
    Invoke-WebRequest -Uri $Uri -OutFile $Destination -UseBasicParsing

    if (-not [string]::IsNullOrWhiteSpace($Sha256)) {
        $actualHash = (Get-FileHash -Path $Destination -Algorithm SHA256).Hash
        if ($actualHash -ne $Sha256) {
            throw "SHA-256 校验失败：$Destination"
        }
    }

    $signature = Get-AuthenticodeSignature -FilePath $Destination
    if ($signature.Status -ne [System.Management.Automation.SignatureStatus]::Valid) {
        throw "数字签名无效：$Destination（状态：$($signature.Status)）"
    }
    if (-not [string]::IsNullOrWhiteSpace($PublisherPattern) -and
        $signature.SignerCertificate.Subject -notmatch $PublisherPattern) {
        throw "发布者不符合预期：$($signature.SignerCertificate.Subject)"
    }
}

function Run-Installer {
    param(
        [string]$Path,
        [string[]]$Arguments,
        [int[]]$AcceptedExitCodes = @(0)
    )

    $process = Start-Process -FilePath $Path -ArgumentList $Arguments -Wait -PassThru
    if ($AcceptedExitCodes -notcontains $process.ExitCode) {
        throw "安装程序退出码为 $($process.ExitCode)：$Path"
    }
    if ($process.ExitCode -eq 3010) {
        Write-Warn "安装成功，但 Windows 需要重启。其余检查仍会继续。"
    }
}

function Invoke-InstallStep {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    try {
        & $Action
    }
    catch {
        $message = "$Name：$($_.Exception.Message)"
        $script:InstallErrors.Add($message)
        Write-Host "[失败] $message" -ForegroundColor Red
    }
}

function Install-Python {
    $version = Get-PythonVersion
    if ($null -ne $version -and $version -ge $MinimumPython) {
        Write-Ok "Python $version 已安装。"
        return
    }

    Write-Step "安装 Python 3.13.15（项目要求 3.9 或更高）"
    $installer = Join-Path $TempFolder "python-3.13.15-amd64.exe"
    Download-VerifiedFile `
        -Uri "https://www.python.org/ftp/python/3.13.15/python-3.13.15-amd64.exe" `
        -Destination $installer `
        -Sha256 "EDEC09C4853AEAE9AC36EFB8C9F95B6B8E2FEE65EEE56D9767A8B7C69C574403" `
        -PublisherPattern "Python Software Foundation"
    Run-Installer -Path $installer -Arguments @(
        "/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_launcher=1", "Include_test=0"
    )
    Refresh-ProcessPath
}

function Install-Git {
    $gitVersion = Get-GitVersion
    $lfsVersion = Get-GitLfsVersion
    if ($null -ne $gitVersion -and $null -ne $lfsVersion) {
        Write-Ok "$gitVersion；$lfsVersion 已安装。"
        & git lfs install
        return
    }

    Write-Step "安装 Git for Windows 2.55.0.5（包含 Git LFS）"
    $installer = Join-Path $TempFolder "Git-2.55.0.5-64-bit.exe"
    Download-VerifiedFile `
        -Uri "https://github.com/git-for-windows/git/releases/download/v2.55.0.windows.5/Git-2.55.0.5-64-bit.exe" `
        -Destination $installer `
        -PublisherPattern "Johannes Schindelin|Open Source Developer|Git for Windows"
    Run-Installer -Path $installer -Arguments @(
        "/SP-", "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART",
        "/COMPONENTS=icons,ext,gitlfs,assoc,assoc_sh,consolefont,windowsterminal"
    )
    Refresh-ProcessPath
    & git lfs install
    if ($LASTEXITCODE -ne 0) {
        throw "Git LFS 初始化失败。"
    }
}

function Get-VsWherePath {
    $path = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path -LiteralPath $path -PathType Leaf) {
        return $path
    }
    return $null
}

function Get-VsCommunityPath {
    param([string]$VersionRange)
    $vswhere = Get-VsWherePath
    if ($null -eq $vswhere) {
        return $null
    }
    try {
        $path = & $vswhere -products Microsoft.VisualStudio.Product.Community `
            -version $VersionRange -latest -property installationPath
        if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace([string]$path)) {
            return ([string]$path).Trim()
        }
    }
    catch {
        return $null
    }
    return $null
}

function Get-VsCommunityChannelId {
    param([string]$VersionRange)
    $vswhere = Get-VsWherePath
    if ($null -eq $vswhere) {
        return $null
    }
    try {
        $channelId = & $vswhere -products Microsoft.VisualStudio.Product.Community `
            -version $VersionRange -latest -property channelId
        if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace([string]$channelId)) {
            return ([string]$channelId).Trim()
        }
    }
    catch {
        return $null
    }
    return $null
}

function Test-VsPackage {
    param(
        [string]$VersionRange,
        [string]$PackageId
    )
    $vswhere = Get-VsWherePath
    if ($null -eq $vswhere) {
        return $false
    }
    try {
        $path = & $vswhere -products Microsoft.VisualStudio.Product.Community `
            -version $VersionRange -latest -requires $PackageId -property installationPath
        return $LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace([string]$path)
    }
    catch {
        return $false
    }
}

function Get-MsvcCompiler {
    param([string]$VsPath)
    if ([string]::IsNullOrWhiteSpace($VsPath)) {
        return $null
    }
    $pattern = Join-Path $VsPath "VC\Tools\MSVC\*\bin\Host*\x64\cl.exe"
    $compilers = Get-ChildItem -Path $pattern -File -ErrorAction SilentlyContinue |
        Sort-Object FullName -Descending
    foreach ($compiler in $compilers) {
        if (Test-Path -LiteralPath (Join-Path $compiler.DirectoryName "link.exe") -PathType Leaf) {
            return $compiler.FullName
        }
    }
    return $null
}

function Get-CompleteWindowsSdkVersion {
    $sdkRoot = Join-Path ${env:ProgramFiles(x86)} "Windows Kits\10"
    $libRoot = Join-Path $sdkRoot "Lib"
    if (-not (Test-Path -LiteralPath $libRoot -PathType Container)) {
        return $null
    }

    $directories = Get-ChildItem -LiteralPath $libRoot -Directory -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending
    foreach ($directory in $directories) {
        $parsed = [version]"0.0"
        if (-not [version]::TryParse($directory.Name, [ref]$parsed) -or $parsed -lt $MinimumSdk) {
            continue
        }
        $required = @(
            (Join-Path $directory.FullName "um\x64\kernel32.lib"),
            (Join-Path $directory.FullName "ucrt\x64\ucrt.lib"),
            (Join-Path $sdkRoot "Include\$($directory.Name)\um\Windows.h"),
            (Join-Path $sdkRoot "Include\$($directory.Name)\shared\sdkddkver.h"),
            (Join-Path $sdkRoot "Include\$($directory.Name)\ucrt\stdio.h"),
            (Join-Path $sdkRoot "bin\$($directory.Name)\x64\rc.exe")
        )
        $complete = $true
        foreach ($file in $required) {
            if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
                $complete = $false
                break
            }
        }
        if ($complete) {
            return $directory.Name
        }
    }
    return $null
}

function Install-OrModifyVisualStudio {
    param(
        [string]$DisplayName,
        [string]$BootstrapperUri,
        [string]$VersionRange,
        [string]$InstallerName
    )

    $vsPath = Get-VsCommunityPath $VersionRange
    Write-Step "安装/补全 $DisplayName 的 Unity 与 C++ 工具链"
    $installer = Join-Path $TempFolder $InstallerName
    Download-VerifiedFile `
        -Uri $BootstrapperUri `
        -Destination $installer `
        -PublisherPattern "Microsoft Corporation"

    $arguments = @()
    if ($null -ne $vsPath) {
        $channelId = Get-VsCommunityChannelId $VersionRange
        if ([string]::IsNullOrWhiteSpace($channelId)) {
            throw "已找到 $DisplayName，但无法读取它的 channelId，无法安全补装组件。"
        }
        $arguments += @(
            "modify", "--installPath", "`"$vsPath`"", "--channelId", $channelId,
            "--productId", "Microsoft.VisualStudio.Product.Community"
        )
    }
    $arguments += @(
        "--passive", "--wait", "--norestart", "--nocache",
        "--add", "Microsoft.VisualStudio.Workload.ManagedGame",
        "--add", "Microsoft.VisualStudio.Workload.NativeDesktop",
        "--add", "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
        "--add", "Microsoft.VisualStudio.Component.Windows11SDK.26100",
        "--includeRecommended", "--addProductLang", "zh-CN"
    )
    Run-Installer -Path $installer -Arguments $arguments -AcceptedExitCodes @(0, 3010)
    Refresh-ProcessPath

    $verifiedPath = Get-VsCommunityPath $VersionRange
    $verifiedCompiler = Get-MsvcCompiler $verifiedPath
    $verifiedSdk = Get-CompleteWindowsSdkVersion
    $verifiedUnityTools = Test-VsPackage $VersionRange "Microsoft.VisualStudio.Component.Unity"
    if ($null -eq $verifiedPath -or $null -eq $verifiedCompiler -or
        $null -eq $verifiedSdk -or -not $verifiedUnityTools) {
        throw "$DisplayName 安装结束后的工具链检查未通过。"
    }
}

function Install-VisualStudio {
    $vsPath = Get-VsCommunityPath "[18.0,19.0)"
    $compiler = Get-MsvcCompiler $vsPath
    $sdk = Get-CompleteWindowsSdkVersion
    $unityTools = Test-VsPackage "[18.0,19.0)" "Microsoft.VisualStudio.Component.Unity"
    if ($null -ne $vsPath -and $null -ne $compiler -and $null -ne $sdk -and $unityTools) {
        Write-Ok "Visual Studio 2026 Community、MSVC 和 Windows SDK $sdk 已安装。"
        return
    }

    try {
        Install-OrModifyVisualStudio `
            -DisplayName "Visual Studio 2026 Community" `
            -BootstrapperUri "https://aka.ms/vs/stable/vs_community.exe" `
            -VersionRange "[18.0,19.0)" `
            -InstallerName "vs_community_2026.exe"
    }
    catch {
        Write-Warn "VS 2026 未被当前 Windows 11/安装器接受：$($_.Exception.Message)"
        Write-Warn "自动回退到项目支持的最新 VS 2022 Community。"
        $fallbackPath = Get-VsCommunityPath "[17.0,18.0)"
        $fallbackCompiler = Get-MsvcCompiler $fallbackPath
        $fallbackSdk = Get-CompleteWindowsSdkVersion
        $fallbackUnityTools = Test-VsPackage "[17.0,18.0)" "Microsoft.VisualStudio.Component.Unity"
        if ($null -ne $fallbackPath -and $null -ne $fallbackCompiler -and
            $null -ne $fallbackSdk -and $fallbackUnityTools) {
            Write-Ok "已有 VS 2022 工具链满足项目构建要求。"
            return
        }
        Install-OrModifyVisualStudio `
            -DisplayName "Visual Studio 2022 Community" `
            -BootstrapperUri "https://aka.ms/vs/17/release/vs_community.exe" `
            -VersionRange "[17.0,18.0)" `
            -InstallerName "vs_community_2022.exe"
    }
}

function Get-UnityHubPath {
    $candidate = Join-Path $env:ProgramFiles "Unity Hub\Unity Hub.exe"
    if (Test-Path -LiteralPath $candidate -PathType Leaf) {
        return $candidate
    }
    return $null
}

function Get-UnityEditorPath {
    $candidates = New-Object System.Collections.Generic.List[string]
    $candidates.Add((Join-Path $env:ProgramFiles "Unity\Hub\Editor\$UnityVersion\Editor\Unity.exe"))
    $candidates.Add((Join-Path $env:ProgramFiles "Unity\Unity-$UnityVersion\Editor\Unity.exe"))
    $candidates.Add((Join-Path $env:ProgramFiles "Unity\Editor\Unity.exe"))
    if (-not [string]::IsNullOrWhiteSpace($env:UNITY_EDITOR)) {
        $candidates.Insert(0, $env:UNITY_EDITOR)
    }
    foreach ($candidate in $candidates) {
        if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            continue
        }
        if ($candidate -match [regex]::Escape($UnityVersion)) {
            return $candidate
        }
        try {
            $versionPrefix = $UnityVersion -replace "[a-z][0-9]+$", ""
            $versionInfo = (Get-Item -LiteralPath $candidate).VersionInfo
            if ($versionInfo.ProductVersion -like "$versionPrefix*" -or
                $versionInfo.FileVersion -like "$versionPrefix*") {
                return $candidate
            }
        }
        catch {
            continue
        }
    }
    return $null
}

function Test-Il2CppVariation {
    param(
        [string]$EditorPath,
        [string]$Variation
    )
    if ([string]::IsNullOrWhiteSpace($EditorPath)) {
        return $false
    }
    $editorFolder = Split-Path -Parent $EditorPath
    $path = Join-Path $editorFolder `
        "Data\PlaybackEngines\WindowsStandaloneSupport\Variations\$Variation"
    return Test-Path -LiteralPath $path -PathType Container
}

function Install-UnityHub {
    if ($null -ne (Get-UnityHubPath)) {
        Write-Ok "Unity Hub 已安装。"
        return
    }

    Write-Step "安装 Unity Hub 3.18.2"
    $installer = Join-Path $TempFolder "UnityHubSetup-3.18.2-x64.exe"
    Download-VerifiedFile `
        -Uri "https://public-cdn.cloud.unity3d.com/hub/prod/3.18.2/UnityHubSetup-3.18.2-x64.exe" `
        -Destination $installer `
        -Sha256 "CE69AEA40DF46F5B844470827B0DBDE1A0C1AE403C34008FE899DA94C99D2525" `
        -PublisherPattern "Unity Technologies"
    Run-Installer -Path $installer -Arguments @("/S")
    Refresh-ProcessPath
}

function Run-UnityHubCli {
    param([string[]]$Arguments)
    $hub = Get-UnityHubPath
    if ($null -eq $hub) {
        throw "未找到 Unity Hub。"
    }
    & $hub -- --headless @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Unity Hub 命令失败，退出码：$LASTEXITCODE"
    }
}

function Install-UnityEditorAndIl2Cpp {
    $editor = Get-UnityEditorPath
    $hasRelease = Test-Il2CppVariation $editor "win64_player_nondevelopment_il2cpp"
    $hasDevelopment = Test-Il2CppVariation $editor "win64_player_development_il2cpp"
    if ($null -ne $editor -and $hasRelease -and $hasDevelopment) {
        Write-Ok "Unity $UnityVersion 与 Windows IL2CPP 已安装。"
        return
    }

    $installRoot = Join-Path $env:ProgramFiles "Unity\Hub\Editor"
    if (-not (Test-Path -LiteralPath $installRoot -PathType Container)) {
        [void](New-Item -Path $installRoot -ItemType Directory -Force)
    }
    Run-UnityHubCli @("install-path", "-s", $installRoot)

    if ($null -eq $editor) {
        Write-Step "安装 Unity $UnityVersion 和 Windows Build Support (IL2CPP)"
        Run-UnityHubCli @(
            "install", "--version", $UnityVersion, "--changeset", $UnityChangeset,
            "--module", "windows-il2cpp"
        )
    }
    else {
        Write-Step "为 Unity $UnityVersion 补装 Windows Build Support (IL2CPP)"
        Run-UnityHubCli @(
            "install-modules", "--version", $UnityVersion,
            "--module", "windows-il2cpp"
        )
    }
}

function Add-CheckResult {
    param(
        [string]$Item,
        [bool]$Passed,
        [string]$Details
    )
    $script:Results += [pscustomobject]@{
        结果 = if ($Passed) { "通过" } else { "失败" }
        检查项 = $Item
        详情 = $Details
    }
}

function Run-FinalScan {
    Refresh-ProcessPath
    $script:Results = @()

    $caption = (Get-CimInstance Win32_OperatingSystem).Caption
    $supportedOs = [Environment]::Is64BitOperatingSystem -and
        ($caption -match "Windows 11|Windows Server 2019|Windows Server 2022|Windows Server 2025")
    Add-CheckResult "受支持的 64 位 Windows" $supportedOs $caption

    $python = Get-PythonVersion
    Add-CheckResult "Python 3.9+" ($null -ne $python -and $python -ge $MinimumPython) `
        $(if ($null -eq $python) { "未找到" } else { $python.ToString() })

    $git = Get-GitVersion
    Add-CheckResult "Git" ($null -ne $git) $(if ($null -eq $git) { "未找到" } else { $git })

    $lfs = Get-GitLfsVersion
    Add-CheckResult "Git LFS" ($null -ne $lfs) $(if ($null -eq $lfs) { "未找到" } else { $lfs })

    $vsRange = "[18.0,19.0)"
    $vsLabel = "Visual Studio 2026 Community"
    $vsPath = Get-VsCommunityPath $vsRange
    $vsCompiler = Get-MsvcCompiler $vsPath
    $vsUnityTools = Test-VsPackage $vsRange "Microsoft.VisualStudio.Component.Unity"
    if ($null -eq $vsPath -or $null -eq $vsCompiler -or -not $vsUnityTools) {
        $vsRange = "[17.0,18.0)"
        $vsLabel = "兼容回退 Visual Studio 2022 Community"
        $vsPath = Get-VsCommunityPath $vsRange
        $vsCompiler = Get-MsvcCompiler $vsPath
        $vsUnityTools = Test-VsPackage $vsRange "Microsoft.VisualStudio.Component.Unity"
    }
    Add-CheckResult "Visual Studio 2026/兼容 VS 2022" ($null -ne $vsPath) `
        $(if ($null -eq $vsPath) { "未找到可用版本" } else { "$vsLabel：$vsPath" })

    Add-CheckResult "Visual Studio Tools for Unity" $vsUnityTools `
        $(if ($vsUnityTools) { "已安装" } else { "缺少 Microsoft.VisualStudio.Component.Unity" })

    Add-CheckResult "MSVC x64 编译器和链接器" ($null -ne $vsCompiler) `
        $(if ($null -eq $vsCompiler) { "cl.exe/link.exe 不完整" } else { $vsCompiler })

    $sdk = Get-CompleteWindowsSdkVersion
    Add-CheckResult "Windows SDK/UCRT/rc.exe" ($null -ne $sdk) `
        $(if ($null -eq $sdk) { "未找到完整的 10.0.19041.0+ SDK" } else { $sdk })

    $hub = Get-UnityHubPath
    Add-CheckResult "Unity Hub" ($null -ne $hub) `
        $(if ($null -eq $hub) { "未找到" } else { $hub })

    $editor = Get-UnityEditorPath
    Add-CheckResult "Unity $UnityVersion" ($null -ne $editor) `
        $(if ($null -eq $editor) { "未找到" } else { $editor })

    $releaseIl2Cpp = Test-Il2CppVariation $editor "win64_player_nondevelopment_il2cpp"
    Add-CheckResult "Windows IL2CPP（Release）" $releaseIl2Cpp `
        $(if ($releaseIl2Cpp) { "已安装" } else { "缺少 nondevelopment IL2CPP player" })

    $developmentIl2Cpp = Test-Il2CppVariation $editor "win64_player_development_il2cpp"
    Add-CheckResult "Windows IL2CPP（Development）" $developmentIl2Cpp `
        $(if ($developmentIl2Cpp) { "已安装" } else { "缺少 development IL2CPP player" })

    Write-Title "最终环境扫描结果"
    $table = $script:Results | Format-Table -AutoSize | Out-String -Width 220
    Write-Host $table

    $failed = @($script:Results | Where-Object { $_.结果 -eq "失败" })
    if ($script:InstallErrors.Count -gt 0) {
        Write-Host "安装阶段记录到以下错误：" -ForegroundColor Red
        foreach ($errorMessage in $script:InstallErrors) {
            Write-Host "  - $errorMessage" -ForegroundColor Red
        }
    }

    Write-Warn "Unity 许可证无法由此脚本代为登录或激活。首次构建前请打开 Unity Hub，登录并激活许可证。"
    Write-Warn "克隆项目后请在仓库目录运行：git lfs pull"
    Write-Warn "首次打开项目后确认 Console 无错误，并按项目文档生成/校验 Build Profiles。"

    return $failed.Count
}

Write-Title "《Where the Roots Dance》Windows IL2CPP 构建环境安装器"
Write-Host "将安装或检查："
Write-Host "  1. Python 3.9+（自动安装 3.13.15）"
Write-Host "  2. Git for Windows + Git LFS"
Write-Host "  3. Visual Studio 2026 Community + Unity/C++ 工作负载"
Write-Host "  4. MSVC x64/x86、Windows SDK、UCRT、rc.exe"
Write-Host "  5. Unity Hub、Unity $UnityVersion、Windows Build Support (IL2CPP)"

$logPath = Join-Path (Split-Path -Parent $PSCommandPath) `
    ("安装日志-{0}.txt" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
try {
    Start-Transcript -Path $logPath -Force | Out-Null
    $script:TranscriptStarted = $true
    Write-Host "日志：$logPath"
}
catch {
    Write-Warn "无法创建日志文件，将继续安装：$($_.Exception.Message)"
}

try {
    $caption = (Get-CimInstance Win32_OperatingSystem).Caption
    if (-not [Environment]::Is64BitOperatingSystem) {
        throw "只支持 64 位 Windows。"
    }
    if ($caption -notmatch "Windows 11|Windows Server 2019|Windows Server 2022|Windows Server 2025") {
        throw "Visual Studio 2026 不支持当前系统：$caption。请升级到受支持的 Windows 11。"
    }

    $systemDrive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$env:SystemDrive'"
    $freeGb = [math]::Round($systemDrive.FreeSpace / 1GB, 1)
    Write-Host "系统：$caption；系统盘可用空间：$freeGb GB"
    if ($freeGb -lt $MinimumFreeGb) {
        Write-Warn "建议至少准备 $MinimumFreeGb GB 可用空间；当前空间可能不足。"
    }

    if ($CheckOnly) {
        Write-Warn "当前为仅检查模式，不会安装任何内容。"
    }
    else {
        if (-not (Test-Path -LiteralPath $TempFolder -PathType Container)) {
            [void](New-Item -Path $TempFolder -ItemType Directory -Force)
        }
        Invoke-InstallStep "Python" { Install-Python }
        Invoke-InstallStep "Git/Git LFS" { Install-Git }
        Invoke-InstallStep "Visual Studio 2026" { Install-VisualStudio }
        Invoke-InstallStep "Unity Hub" { Install-UnityHub }
        Invoke-InstallStep "Unity/Windows IL2CPP" { Install-UnityEditorAndIl2Cpp }
    }
}
catch {
    $script:InstallErrors.Add("前置检查：$($_.Exception.Message)")
    Write-Host "[失败] $($_.Exception.Message)" -ForegroundColor Red
}

$failedCount = Run-FinalScan
if ($script:TranscriptStarted) {
    Stop-Transcript | Out-Null
}

if ($failedCount -eq 0) {
    Write-Host ""
    Write-Host "环境安装与检查全部通过。完成许可证激活后即可进行 Windows IL2CPP 构建。" `
        -ForegroundColor Green
    Wait-BeforeExit
    exit 0
}

Write-Host ""
Write-Host "仍有 $failedCount 项未通过。请查看上方详情和安装日志。" -ForegroundColor Red
Wait-BeforeExit
exit 1
