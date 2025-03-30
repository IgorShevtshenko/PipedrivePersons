import PersonsRepository
import Domain
import APIKeyRepository
import Combine
import ArchitectureKit

@MainActor
public final class PersonsPresenter: Presenter<PersonsState, PersonsAction> {
    
    private let dependencies: Dependencies
    
    private let events = PassthroughSubject<PersonsEvent, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        dependencies: Dependencies,
        reducer: @escaping (PersonsState, PersonsEvent) -> State = PersonsReducer.reduce
    ) {
        self.dependencies = dependencies
        
        let persons = dependencies.personsRepository.persons
            .map(PersonsEvent.didChangePersons)
        
        super.init(
            initial: .init(),
            dataEvents: events.merge(with: persons),
            reducer: reducer
        )
        
        send(.initialFetching)
    }
    
    public override func send(_ action: PersonsAction) {
        Task { [dependencies] in
            switch action {
            case .fetchPersons:
                do throws(FetchPersonsError) {
                    events.send(.didStartFetchingPersons)
                    try await dependencies.personsRepository.fetchPersons()
                } catch {
                    events.send(.didFailFetching(.init(from: error)))
                }
                
            case .fetchMorePersons:
                do throws(FetchPersonsError) {
                    try await dependencies.personsRepository.fetchMorePersons()
                } catch {
                    events.send(.didFailFetching(.init(from: error)))
                }
                
            case .initialFetching:
                do throws(FetchAPIKeyError) {
                    try await dependencies.apiKeyRepository.fetchAPIKey()
                    send(.fetchPersons)
                } catch {
                    events.send(.didFailFetching(.init(from: error)))
                }
            }
        }
        .store(in: &cancellables)
    }
}

public extension PersonsState.PersonsError {
    
    init(from error: FetchPersonsError) {
        switch error {
        case .general:
            self = .fetchingPersonsFailed
        }
    }
    
    init(from error: FetchAPIKeyError) {
        switch error {
        case .general:
            self = .fetchingAPIKeyFailed
        }
    }
}
