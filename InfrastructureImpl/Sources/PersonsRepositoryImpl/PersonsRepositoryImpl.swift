import Combine
import Domain
import Networking
import Utils
import PersonsRepository
import Foundation

public final class PersonsRepositoryImpl: PersonsRepository {
    
    public var persons: ProtectedPublisher<PaginatedArray<Person>> {
        _persons.eraseToAnyPublisher()
    }
    
    private let _persons = CurrentValueSubject<PaginatedArray<Person>, Never>(
        .init(elements: [], cursor: .page(""))
    )
    
    private let pageLimit = 10
    private let networkClient: NetworkClient
    
    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    public func fetchPersons() async throws(FetchPersonsError) {
        let persons = try await persons()
        _persons.send(persons)
    }
    
    public func fetchMorePersons() async throws(FetchPersonsError) {
        let currentPersons = _persons.value
        guard case .page(let cursor) = currentPersons.cursor else {
            return
        }
        do {
            let newPersons = try await persons(cursor: cursor)
            _persons.send(
                PaginatedArray(
                    elements: currentPersons.elements + newPersons.elements,
                    cursor: newPersons.cursor
                )
            )
        }
    }
    
    private func persons(
        cursor: String? = nil
    ) async throws(FetchPersonsError) -> PaginatedArray<Person> {
        do {
            let cursorQuery: [URLQueryItem] = if let cursor {
                [.init(name: "cursor", value: cursor)]
            } else {
                []
            }
            let personsResponse = try await networkClient.get(
                path: "persons",
                queryItems: [.init(name: "limit", value: "\(pageLimit)")] + cursorQuery,
                responseType: PersonsResponse.self
            )
            return PaginatedArray(
                elements: personsResponse.data
                    .map(Person.init),
                cursor: .init(from: personsResponse.additional_data)
            )
        } catch {
            throw FetchPersonsError(from: error)
        }
    }
}

private extension FetchPersonsError {
    
    init(from error: NetworkError) {
        switch error {
        case .general,
                .externalError,
                .noInternetConnection:
            self = .general
        }
    }
}
