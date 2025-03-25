import APIKeyRepository
import Foundation

public actor APIKeyRepositoryImpl: APIKeyRepository {
    
    public var apiKey = ""
    
    public init() {}
    
    public func fetchAPIKey() async throws(FetchAPIKeyError) {
        //MARK: In real app should be received from server
        apiKey = "329f44afae84394b81c02ec85dc0e5e5b99f4a8e"
    }
}
