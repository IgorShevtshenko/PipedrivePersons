import PersonsRepository
import APIKeyRepository

public extension PersonsPresenter {
    
    struct Dependencies {
        let personsRepository: PersonsRepository
        let apiKeyRepository: APIKeyRepository
        
        public init(personsRepository: PersonsRepository, apiKeyRepository: APIKeyRepository) {
            self.personsRepository = personsRepository
            self.apiKeyRepository = apiKeyRepository
        }
    }
}
