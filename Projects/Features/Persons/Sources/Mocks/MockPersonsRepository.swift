import Combine
import Utils
import Domain
import PersonsRepository

final class MockPersonsRepository: PersonsRepository, ObservableObject {
    
    var persons: ProtectedPublisher<PaginatedArray<Person>> {
        _persons.eraseToAnyPublisher()
    }
    
    private let _persons = CurrentValueSubject<PaginatedArray<Person>, Never>(
        .init(elements: [], cursor: .end)
    )
    
    init() {}
    
    func fetchPersons() async throws(FetchPersonsError) {
        try? await Task.sleep(for: .seconds(1))
        _persons.send(
            .init(
                elements: [
                    .init(
                        id: 1,
                        name: "John Doe",
                        phones: [.init(label: "Work", contact: "+372 5743 2849")],
                        emails: [.init(label: "Work", contact: "test@gmail.com")]
                    )
                ],
                cursor: .page("1")
            )
        )
    }
    
    func fetchMorePersons() async throws(FetchPersonsError) {
        try? await Task.sleep(for: .seconds(1))
        _persons.send(
            .init(
                elements: _persons.value.elements + [
                    .init(
                        id: 2,
                        name: "Jane Doe",
                        phones: [.init(label: "Work", contact: "+372 7440 1654")],
                        emails: [.init(label: "Work", contact: "mock@gmail.com")]
                    )
                ],
                cursor: .end
            )
        )
    }
}
