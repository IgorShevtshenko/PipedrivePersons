import Combine
import Domain
import Utils

public enum FetchPersonsError: Error {
    case general
}

public protocol PersonsRepository {
    var persons: ProtectedPublisher<PaginatedArray<Person>> { get }
    func fetchPersons() async throws(FetchPersonsError)
    func fetchMorePersons() async throws(FetchPersonsError)
}
