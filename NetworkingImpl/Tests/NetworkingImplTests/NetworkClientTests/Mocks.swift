import Networking
import Foundation

struct MockURLSession: URLSessionProtocol {
    
    let onData: (URLRequest) async throws -> (Data, URLResponse)
    
    func data(using request: URLRequest) async throws -> (Data, URLResponse) {
        try await onData(request)
    }
}

struct MockRequestSerializer: RequestSerializer {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        Data()
    }
    
    func configureContentType(on urlRequest: URLRequest) -> URLRequest {
        urlRequest
    }
}

struct MockResponseSerializer: ResponseSerializer {
    
    let onDecode: (Data) throws -> Any
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        try onDecode(data) as! T
    }
}

struct MockEndpointConfiguration: EndpointConfiguration {

    func url(applying path: String, queryItems: [URLQueryItem]) async -> URL? {
        URL(string: "https://example.com")
    }
    
    func configureRequest(url: URL, method: Networking.HTTPMethod, body: Data?) -> URLRequest {
        URLRequest(url: url)
    }
}
 
final class MockHTTPURLResponse: HTTPURLResponse, @unchecked Sendable {
    
    let code: Int
    
    init(code: Int) {
        self.code = code
        super.init(
            url: URL(string: "https://example.com")!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var statusCode: Int {
        code
    }
}
