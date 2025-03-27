enum SampleReducer {
    
    static func reduce(state: SampleState, event: SampleEvent) -> SampleState {
        var state = state
        switch event {
        case .didChangeNumber(let int):
            state.count = int
        case .didStartLoading:
            state.isLoading = true
        case .didFinishLoading:
            state.isLoading = false
        }
        return state
    }
}
