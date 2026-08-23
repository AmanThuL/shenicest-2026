---
title: "patterns demo: SimplePlayerStateMachine.cs"
source_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/5_State/Scripts/Pattern/SimpleStateMachine/SimplePlayerStateMachine.cs"
final_url: "https://raw.githubusercontent.com/Unity-Technologies/game-programming-patterns-demo/main/Assets/UnityTechnologies/_DesignPatterns/5_State/Scripts/Pattern/SimpleStateMachine/SimplePlayerStateMachine.cs"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "source"
---

# patterns demo: SimplePlayerStateMachine.cs

```cs
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DesignPatterns.StatePattern
{
    // handles
    [Serializable]
    public class SimplePlayerStateMachine
    {
        public IState CurrentState { get; private set; }

        // reference to the state objects
        public WalkState walkState;
        public JumpState jumpState;
        public IdleState idleState;

        // event to notify other objects of the state change
        public event Action<IState> stateChanged;

        // pass in necessary parameters into constructor 
        public SimplePlayerStateMachine(PlayerController player)
        {
            // create an instance for each state and pass in PlayerController
            this.walkState = new WalkState(player);
            this.jumpState = new JumpState(player);
            this.idleState = new IdleState(player);
        }

        // set the starting state
        public void Initialize(IState state)
        {
            CurrentState = state;
            state.Enter();

            // notify other objects that state has changed
            stateChanged?.Invoke(state);
        }

        // exit this state and enter another
        public void TransitionTo(IState nextState)
        {
            CurrentState.Exit();
            CurrentState = nextState;
            nextState.Enter();

            // notify other objects that state has changed
            stateChanged?.Invoke(nextState);
        }

        // allow the StateMachine to update this state
        public void Execute()
        {
            if (CurrentState != null)
            {
                CurrentState.Execute();
            }
        }
    }
}

```
