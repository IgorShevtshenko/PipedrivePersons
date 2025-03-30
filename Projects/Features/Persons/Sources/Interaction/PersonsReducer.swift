public enum PersonsReducer {
    
    public static func reduce(state: PersonsState, event: PersonsEvent) -> PersonsState {
        var state = state
        switch event {
        case .didChangePersons(let persons):
            state.viewState = persons.elements.isEmpty ? .empty : .success(persons.elements)
            state.isMoreAvailable = persons.cursor != .end
            
        case .didStartFetchingPersons:
            state.viewState = .loading
            
        case .didFailFetching(let error):
            state.viewState = .failed(error)
            
        case .didChangeSelectedPerson(let person):
            state.selectedPerson = person
        }
        return state
    }
}
