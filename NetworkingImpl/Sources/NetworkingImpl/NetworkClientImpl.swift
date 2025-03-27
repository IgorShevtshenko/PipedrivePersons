import Foundation
import Networking

private struct ErrorResponse: Decodable, Error {
    let message: String
}

public struct NetworkClientImpl: NetworkClient {
    
    private let urlSession: URLSessionProtocol
    private let requestSerializer: RequestSerializer
    private let responseSerializer: ResponseSerializer
    private let endpointConfiguration: EndpointConfiguration
    
    public init(
        urlSession: URLSessionProtocol,
        requestSerializer: RequestSerializer,
        responseSerializer: ResponseSerializer,
        endpointConfiguration: EndpointConfiguration
    ) {
        self.urlSession = urlSession
        self.requestSerializer = requestSerializer
        self.responseSerializer = responseSerializer
        self.endpointConfiguration = endpointConfiguration
    }
    
    public func execute<ResponseType: Decodable>(
        method: HTTPMethod,
        path: String,
        queryItems: [URLQueryItem],
        body: (some Encodable)?,
        responseType: ResponseType.Type
    ) async throws(NetworkError) -> ResponseType {
        let url = try await prepareURL(path: path, queryItems: queryItems)
        let request = try prepareRequest(
            method: method,
            url: url,
            body: body
        )
        let (data, response) = try await response(for: request)
        let validatedData = try response.validate(data: data)
        guard
            let decodedResponse = try? responseSerializer.decode(
                ResponseType.self,
                from: validatedData
            )
        else {
            throw NetworkError.general
        }
        return decodedResponse
    }
}

private struct ErrorEntity: Decodable {
    let errorCode: Int
}

private extension NetworkClientImpl {
    
    func prepareRequest(
        method: HTTPMethod,
        url: URL,
        body: (some Encodable)?
    ) throws(NetworkError) -> URLRequest {
        do {
            return try requestSerializer.configureContentType(
                on: endpointConfiguration.configureRequest(
                    url: url,
                    method: method,
                    body: body.map(requestSerializer.encode)
                )
            )
        } catch {
            throw .general
        }
    }
    
    func response(for request: URLRequest) async throws(NetworkError) -> (Data, URLResponse) {
        do {
            return try await urlSession.data(using: request)
        } catch {
            throw error.identifiedConnectionError
        }
    }
}

private extension URLResponse {
    
    func validate(data: Data) throws(NetworkError) -> Data {
        guard let response = self as? HTTPURLResponse else { throw .general }
        
        guard (200...299).contains(response.statusCode) else {
            guard
                let errorCode = try? JSONDecoder().decode(ErrorEntity.self, from: data).errorCode
            else {
                throw .general
            }
            throw .externalError(errorCode)
        }
        return data
    }
}


private extension Error {
    
    var identifiedConnectionError: NetworkError {
        if (self as NSError).code == URLError.Code.notConnectedToInternet.rawValue {
            return .noInternetConnection
        } else {
            return .general
        }
    }
}

private extension NetworkClientImpl {
    
    func prepareURL(
        path: String,
        queryItems: [URLQueryItem]
    ) async throws(NetworkError) -> URL {
        guard
            let url = await endpointConfiguration.url(applying: path, queryItems: queryItems)
        else {
            throw .general
        }
        return url
    }
}

