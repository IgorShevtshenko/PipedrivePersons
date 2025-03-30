import Testing
import ArchitectureTesting
import Combine
import Utils
import Domain
import APIKeyRepository
import PersonsRepository
@testable import Persons

@MainActor
struct PersonsPresenterTests {
    
    private let reducer: TestingReducer<PersonsState, PersonsEvent>
    private let presenter: PersonsPresenter
    
    init() {
        self.reducer = TestingReducer(reducer: PersonsReducer.reduce)
        self.presenter = PersonsPresenter(
            dependencies: .init(
                personsRepository: MockPersonsRepository(),
                apiKeyRepository: MockAPIKeyRepository()
            ),
            reducer: reducer.reduce
        )
    }
    
    @Test("Start loading before fetching")
    func testFetchPersonsSuccess() async {
        let expectedEvents = [
            PersonsEvent.didStartFetchingPersons,
        ]
        presenter.send(.fetchPersons)
        await reducer.expectEvents(expectedEvents, timeout: 0.1)
    }
}

private struct MockPersonsRepository: PersonsRepository {
    
    var persons: ProtectedPublisher<PaginatedArray<Person>> {
        Empty().eraseToAnyPublisher()
    }
    
    func fetchPersons() async throws(FetchPersonsError) {}
    func fetchMorePersons() async throws(FetchPersonsError) {}
}

private struct MockAPIKeyRepository: APIKeyRepository {
    var apiKey = ""
    
    func fetchAPIKey() async throws(FetchAPIKeyError) {}
}
