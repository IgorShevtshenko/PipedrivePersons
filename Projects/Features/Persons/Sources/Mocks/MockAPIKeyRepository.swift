import APIKeyRepository
import SwiftUI

final class MockAPIKeyRepository: APIKeyRepository, ObservableObject {
    
    let apiKey: String = ""
    
    func fetchAPIKey() async throws(FetchAPIKeyError) {}
}
