import SwiftUI
import Combine

open class Presenter<State, Action>: ObservableObject {
    
    public typealias State = State
    public typealias Action = Action
    
    @Published public private(set) var state: State

    public init<Event, EventPublisher: Publisher>(
        initial: State,
        dataEvents: EventPublisher,
        reducer: @escaping (State, Event) -> State
    ) where EventPublisher.Output == Event, EventPublisher.Failure == Never {
        state = initial
        dataEvents
            .receive(on: DispatchQueue.main)
            .scan(initial, reducer)
            .assign(to: &$state)
    }

    public init(constantState: State) {
        state = constantState
    }
    
    @MainActor
    open func send(_ action: Action) {}
}
