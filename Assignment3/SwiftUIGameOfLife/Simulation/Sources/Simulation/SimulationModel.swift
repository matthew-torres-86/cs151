//
//  Simulation.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import ComposableArchitecture
import Combine
import Dispatch
import Grid
import GameOfLife

public struct SimulationState {
    public var gridState = GridState()
    public var isRunningTimer: Bool

    public init(gridState: GridState = GridState()) {
        self.gridState = gridState
        self.isRunningTimer = false
    }
}

extension SimulationState: Equatable { }

extension SimulationState: Codable { }

public extension SimulationState {
    enum Action: Equatable {
        case none
        case tick
        case startTimer
        case stopTimer
        case reset
        case update(grid: Grid)
        case grid(action: GridState.Action)
        case resetGridToEmpty
        case resetGridToRandom
    }
    
    enum Identifiers: Hashable {
        case simulationTimer
        case simulationCancellable
    }
}

public struct SimulationEnvironment {
    var scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    var gridEnvironment = GridEnvironment()
    var timerEffectCancellable: AnyCancellable? = .none
    
    public init(
        scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler(),
        gridEnvironment: GridEnvironment = GridEnvironment()
    ) {
        self.scheduler = scheduler
        self.gridEnvironment = gridEnvironment
    }
}

public let simulationReducer = Reducer<SimulationState, SimulationState.Action, SimulationEnvironment>.combine(
    
    gridReducer.pullback(
        state: \SimulationState.gridState,
        action: /SimulationState.Action.grid(action:),
        environment: \.gridEnvironment
    ),
    
    Reducer<SimulationState, SimulationState.Action, SimulationEnvironment>{ state, action, env in
        switch action {
            case .none:
                return .none
            case .tick:
                state.gridState.ticks = state.gridState.ticks + 1
                state.gridState.grid = state.gridState.grid.next
                return .none
            case .startTimer:
                state.isRunningTimer = true
                return Effect.timer(
                    id: SimulationState.Identifiers.simulationTimer,
                    every:  1.0,
                    on: env.scheduler)
                .map{ _ in .tick }
                .cancellable(id: SimulationState.Identifiers.simulationCancellable)
            case .stopTimer:
                state.isRunningTimer = false
                return .cancel(id: SimulationState.Identifiers.simulationTimer)
            case .reset:
                state.gridState.ticks = 0
                return .none
            case .update(grid: let grid):
                state.gridState.grid = grid
                return .none
            case .grid(action:):
                return .none
            case .resetGridToEmpty:
                state.gridState.grid = Grid(10, 10, Grid.Initializers.empty)
                return .none
            case .resetGridToRandom:
                state.gridState.grid = Grid(10, 10, Grid.Initializers.random)
                return .none
        }
    }
)

