import Networking
import Foundation
import APIKeyRepository

public struct AuthenticatedEndpointConfigurationDecorator: EndpointConfiguration {
    
    private let apiKeyRepository: APIKeyRepository
    private let endpointConfiguration: EndpointConfiguration
    
    public init(apiKeyRepository: APIKeyRepository, endpointConfiguration: EndpointConfiguration) {
        self.apiKeyRepository = apiKeyRepository
        self.endpointConfiguration = endpointConfiguration
    }
    
    public func url(applying path: String, queryItems: [URLQueryItem]) async -> URL? {
        await endpointConfiguration.url(
            applying: path,
            queryItems: queryItems + [.init(name: "api_token", value: apiKeyRepository.apiKey)]
        )
    }
    
    public func configureRequest(url: URL, method: HTTPMethod, body: Data?) -> URLRequest {
        endpointConfiguration.configureRequest(url: url, method: method, body: body)
    }
}
