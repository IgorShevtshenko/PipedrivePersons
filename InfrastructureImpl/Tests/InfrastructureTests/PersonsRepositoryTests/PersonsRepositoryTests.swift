import Testing
import Combine
import Networking
import Foundation
import Domain
@testable import PersonsRepositoryImpl

struct PersonsRepositoryTests {
    
    private let networkClient = MockNetworkClient()
    
    private lazy var personsRepository = PersonsRepositoryImpl(networkClient: networkClient)
    
    @Test("Initial fetch")
    mutating func testInitialFetch() async throws {
        let expectedPersons = PaginatedArray(
            elements: [Person.mock(id: 1)],
            cursor: .page("1")
        )
        networkClient.onExecute = {
            PersonsResponse(
                data: [.mock(id: 1)],
                additional_data: .init(next_cursor: "1")
            )
        }
        try? await personsRepository.fetchPersons()
        let persons = await personsRepository.persons.values.first(where: { _ in true })
        #expect(persons == expectedPersons)
    }
    
    @Test("Fetch more persons")
    mutating func testFetchMorePersons() async throws {
        let expectedPersons = PaginatedArray(
            elements: [
                Person.mock(id: 1),
                .mock(id: 2)
            ],
            cursor: .page("2")
        )
        networkClient.onExecute = {
            PersonsResponse(
                data: [.mock(id: 1)],
                additional_data: .init(next_cursor: "1")
            )
        }
        try? await personsRepository.fetchPersons()
        let persons = await personsRepository.persons.values.first(where: { _ in true })
        #expect(persons == PaginatedArray(elements: [.mock(id: 1)], cursor: .page("1")))
        
        networkClient.onExecute = {
            PersonsResponse(
                data: [.mock(id: 2)],
                additional_data: .init(next_cursor: "2")
            )
        }
        try? await personsRepository.fetchMorePersons()
        let morePersons =  await personsRepository.persons.values.first(where: { _ in true })
        #expect(morePersons == expectedPersons)
    }
    
    @Test("End cursor for end of list")
    mutating func testEndCursor() async throws {
        let expectedPersons = PaginatedArray(
            elements: [Person.mock(id: 1)],
            cursor: .end
        )
        networkClient.onExecute = {
            PersonsResponse(
                data: [.mock(id: 1)],
                additional_data: .init(next_cursor: nil)
            )
        }
        try? await personsRepository.fetchPersons()
        let persons = await personsRepository.persons.values.first(where: { _ in true })
        #expect(persons == expectedPersons)
    }
}

private final class MockNetworkClient: NetworkClient {
    
    var onExecute: () -> Any
    
    init(onExecute: @escaping () -> Any = { "" }) {
        self.onExecute = onExecute
    }
    
    func execute<ResponseType: Decodable>(
        method: HTTPMethod,
        path: String,
        queryItems: [URLQueryItem],
        body: (some Encodable)?,
        responseType: ResponseType.Type
    ) async throws(NetworkError) -> ResponseType {
        onExecute() as! ResponseType
    }
}
