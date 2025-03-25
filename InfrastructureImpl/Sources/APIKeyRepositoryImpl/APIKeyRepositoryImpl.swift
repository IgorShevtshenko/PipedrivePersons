import APIKeyRepository
import Foundation

public actor APIKeyRepositoryImpl: APIKeyRepository {
    
    private let tag: String = "APIKey"
    
    private let bundle: Bundle
    private let decoder: JSONDecoder
    
    public var apiKey = ""
    
    public init(
        bundle: Bundle = .main,
        decoder: JSONDecoder = .init()
    ) {
        self.bundle = bundle
        self.decoder = decoder
    }
    
    public func fetchAPIKey() async throws(FetchAPIKeyError) {
        let request = NSBundleResourceRequest(tags: [tag])
        do {
            try await request.beginAccessingResources()
            guard
                let url = bundle.url(forResource: tag, withExtension: "json")
            else {
                throw FetchAPIKeyError.general
            }
            let data = try Data(contentsOf: url)
            
            request.endAccessingResources()
            
            apiKey = try decoder.decode(String.self, from: data)
        } catch {
            throw .general
        }
    }
}
