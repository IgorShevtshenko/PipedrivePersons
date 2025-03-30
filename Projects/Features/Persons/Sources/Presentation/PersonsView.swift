import ArchitectureKit
import SwiftUI
import UILibrary

public struct PersonsView: View {
    
    @ObservedObject private var presenter: Presenter<PersonsState, PersonsAction>
    
    public init(presenter: Presenter<PersonsState, PersonsAction>) {
        self.presenter = presenter
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                switch presenter.state.viewState {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(
                        text: text(for: error),
                        tryAgain: { tryAgain(for: error) }
                    )
                case .success(let persons):
                    PrimaryList(items: persons) { person in
                        PersonCell(person: person)
                            .onAppear {
                                if persons.last == person, presenter.state.isMoreAvailable {
                                    presenter.send(.fetchMorePersons)
                                }
                            }
                    }
                case .empty:
                    ErrorView(
                        text: localisables.persons.noPersons,
                        tryAgain: { presenter.send(.fetchPersons) }
                    )
                }
            }
            .navigationTitle(localisables.persons.navTitle)
            .animation(.default, value: presenter.state.viewState)
        }
    }
}

private extension PersonsView {
    
    func text(for error: PersonsState.PersonsError) -> String {
        switch error {
        case .fetchingAPIKeyFailed, .fetchingPersonsFailed:
            localisables.common.somethingWentWrong
        }
    }
    
    func tryAgain(for error: PersonsState.PersonsError) {
        switch error {
        case .fetchingPersonsFailed:
            presenter.send(.fetchPersons)
            
        case .fetchingAPIKeyFailed:
            presenter.send(.initialFetching)
        }
    }
}

#Preview("List") {
    PersonsView(
        presenter: .init(
            constantState: .init(
                viewState: .success([.mock(id: 1), .mock(id: 2)])
            )
        )
    )
}

#Preview("Loading") {
    PersonsView(
        presenter: .init(
            constantState: .init(viewState: .loading)
        )
    )
}

#Preview("Empty") {
    PersonsView(
        presenter: .init(
            constantState: .init(viewState: .empty)
        )
    )
}

#Preview("Failed fetching persons") {
    PersonsView(
        presenter: .init(
            constantState: .init(viewState: .failed(.fetchingPersonsFailed))
        )
    )
}

#Preview("Failed fetching api key") {
    PersonsView(
        presenter: .init(
            constantState: .init(viewState: .failed(.fetchingAPIKeyFailed))
        )
    )
}
