import Testing
import Combine
import Utils
import Foundation

public enum TestingReducerError: Error {
    case timeout
}

public final class TestingReducer<State, Event: Equatable> {
    
    private let events = CurrentValueSubject<[Event], Never>([])
    
    private let reducer: (State, Event) -> State
    
    private var cancellables = Set<AnyCancellable>()
    
    init(reducer: @escaping (State, Event) -> State) {
        self.reducer = reducer
    }
    
    @MainActor
    func expectEvents(_ expectedEvents: [Event], timeout: TimeInterval) async  {
        await confirmation { confirmation in
            do {
                try await withCheckedThrowingContinuation { continuation in
                    events.sink { events in
                        if expectedEvents == events {
                            continuation.resume()
                        }
                    }
                    .store(in: &cancellables)
                    
                    Timer.publish(every: timeout, on: .main, in: .default)
                        .autoconnect()
                        .sink { _ in
                            continuation.resume(throwing: TestingReducerError.timeout)
                        }
                        .store(in: &cancellables)
                }
                confirmation.confirm()
            } catch {
                confirmation.confirm(count: 2)
            }
        }
    }
    
    func reduce(state: State, event: Event) -> State {
        events.send(events.value + [event])
        return reducer(state, event)
    }
}
