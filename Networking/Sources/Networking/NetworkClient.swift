import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol NetworkClient {
    func execute<ResponseType: Decodable>(
        method: HTTPMethod,
        path: String,
        queryItems: [URLQueryItem],
        body: (some Encodable)?,
        responseType: ResponseType.Type
    ) async throws(NetworkError) -> ResponseType
}

public extension NetworkClient {
    
    func get<ResponseType: Decodable>(
        path: String,
        responseType: ResponseType.Type
    ) async throws(NetworkError) -> ResponseType {
        try await execute(
            method: .get,
            path: path,
            queryItems: [],
            body: EmptyRequestBody?.none,
            responseType: responseType
        )
    }
}

public struct EmptyRequestBody: Encodable {}
