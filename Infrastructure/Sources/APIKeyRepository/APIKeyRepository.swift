import Foundation

public enum FetchAPIKeyError: Error {
    case general
}

public protocol APIKeyRepository {
    var apiKey: String { get async }
    func fetchAPIKey() async throws(FetchAPIKeyError)
}
