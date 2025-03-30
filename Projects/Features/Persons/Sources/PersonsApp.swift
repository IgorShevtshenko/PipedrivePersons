import SwiftUI

@main
struct PersonsApp: App {
    
    @StateObject private var personsRepository: MockPersonsRepository
    
    @StateObject private var presenter: PersonsPresenter
    
    init() {
        let personsRepository = MockPersonsRepository()
        _personsRepository = StateObject(
            wrappedValue: personsRepository
        )
        _presenter = StateObject(
            wrappedValue: PersonsPresenter(
                dependencies: .init(
                    personsRepository: personsRepository,
                    apiKeyRepository: MockAPIKeyRepository()
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
