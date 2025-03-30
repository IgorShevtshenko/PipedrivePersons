import SwiftUI
import Persons
import Utils
import APIKeyRepository
import APIKeyRepositoryImpl
import Networking
import NetworkingImpl
import PersonsRepository
import PersonsRepositoryImpl
import ArchitectureKit

@main
struct PipedrivePersonsApp: App {
    
    @StateObject private var apiKeyRepository: StateObjectWrapper<APIKeyRepository>
    @StateObject private var personsRepository: StateObjectWrapper<PersonsRepository>
    @StateObject private var presenter: Presenter<PersonsState, PersonsAction>
    
    init() {
        let apiKeyRespository = APIKeyRepositoryImpl()
        let personsRepository = PersonsRepositoryImpl(
            networkClient: NetworkClientImpl(
                urlSession: URLSession.shared,
                requestSerializer: JSONRequestSerializer(),
                responseSerializer: JSONResponseSerializer(),
                endpointConfiguration: AuthenticatedEndpointConfigurationDecorator(
                    apiKeyRepository: apiKeyRespository,
                    endpointConfiguration: EndpointConfigurationImpl()
                )
            )
        )
        _apiKeyRepository = StateObject(
            wrappedValue: StateObjectWrapper(object: apiKeyRespository)
        )
        _personsRepository = StateObject(
            wrappedValue: StateObjectWrapper(object: personsRepository)
        )
        _presenter = StateObject(
            wrappedValue: PersonsPresenter(
                dependencies: .init(
                    personsRepository: personsRepository,
                    apiKeyRepository: apiKeyRespository
                )
            )
        )
    }
    var body: some Scene {
        WindowGroup {
            PersonsView(presenter: presenter)
        }
    }
}
