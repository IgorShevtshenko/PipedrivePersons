import Foundation

public protocol URLSessionProtocol {
    func data(using request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    public func data(using request: URLRequest) async throws-> (Data, URLResponse) {
        try await data(for: request)
    }
}
