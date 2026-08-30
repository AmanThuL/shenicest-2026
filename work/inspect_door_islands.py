import bpy

obj = bpy.data.objects["ClothLandscape_CorridorShell.006"]
mesh = obj.data
neighbors = [set() for _ in mesh.vertices]

for edge in mesh.edges:
    a, b = edge.vertices
    neighbors[a].add(b)
    neighbors[b].add(a)

remaining = set(range(len(mesh.vertices)))
islands = []

while remaining:
    seed = remaining.pop()
    stack = [seed]
    island = {seed}

    while stack:
        current = stack.pop()
        for adjacent in neighbors[current]:
            if adjacent in remaining:
                remaining.remove(adjacent)
                island.add(adjacent)
                stack.append(adjacent)

    coords = [obj.matrix_world @ mesh.vertices[index].co for index in island]
    minimum = tuple(min(value[axis] for value in coords) for axis in range(3))
    maximum = tuple(max(value[axis] for value in coords) for axis in range(3))
    center = tuple((minimum[axis] + maximum[axis]) * 0.5 for axis in range(3))
    size = tuple(maximum[axis] - minimum[axis] for axis in range(3))
    islands.append((len(island), center, size))

for vertex_count, center, size in sorted(islands, key=lambda item: item[1][2]):
    print(
        "DOOR_ISLAND",
        vertex_count,
        "center",
        tuple(round(value, 3) for value in center),
        "size",
        tuple(round(value, 3) for value in size),
    )
