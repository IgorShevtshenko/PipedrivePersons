import Combine
import ArchitectureKit
import Utils

final class SamplePresenter: Presenter<SampleState, SampleAction> {
    
    private let getRandomNumber: () -> Int
    
    private let events = PassthroughSubject<SampleEvent, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getRandomNumber: @escaping () -> Int,
        reducer: @escaping (State, SampleEvent) -> State
    ) {
        self.getRandomNumber = getRandomNumber
        super.init(
            initial: .init(),
            dataEvents: events,
            reducer: reducer
        )
    }
    
    override func send(_ action: Action) {
        Task {
            switch action {
            case .increase:
                events.send(.didStartLoading)
                let newNumber = getRandomNumber()
                events.send(.didChangeNumber(state.count + newNumber))
                events.send(.didFinishLoading)
            }
        }
        .store(in: &cancellables)
    }
}
