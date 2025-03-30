import Domain
import Testing
@testable import Persons

struct PersonsReducerTests {
    
    @Test("ViewState set to .empty on empty array")
    func testHandleEmptyList() async throws {
        let state = PersonsReducer.reduce(
            state: .init(),
            event: .didChangePersons(
                .init(
                    elements: [],
                    cursor: .end
                )
            )
        )
        #expect(state == PersonsState(viewState: .empty))
    }
    
    @Test("IsMoreAvaialable set to false when cursor is .end")
    func testEndOfPagination() async throws {
        let state = PersonsReducer.reduce(
            state: .init(),
            event: .didChangePersons(
                .init(
                    elements: [],
                    cursor: .end
                )
            )
        )
        #expect(state == PersonsState(viewState: .empty, isMoreAvailable: false))
    }
}
