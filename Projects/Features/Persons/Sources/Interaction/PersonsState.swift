import Domain

public struct PersonsState: Equatable {
    var viewState: ViewState = .loading
    var isMoreAvailable = false
    var selectedPerson: Person?
}

public extension PersonsState {
    
    enum ViewState: Equatable {
        case loading
        case failed(PersonsError)
        case success([Person])
        case empty
    }
    
    enum PersonsError: Error, Equatable {
        case fetchingPersonsFailed
        case fetchingAPIKeyFailed
    }
}
