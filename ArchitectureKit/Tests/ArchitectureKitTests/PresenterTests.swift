import Testing
import XCTest
import ArchitectureTesting
@testable import ArchitectureKit

@MainActor
struct PresenterTests {
    
    private let reducer: TestingReducer<SampleState, SampleEvent>
    private let presenter: SamplePresenter
    
    init() {
        self.reducer = TestingReducer(reducer: SampleReducer.reduce)
        self.presenter = SamplePresenter(
            getRandomNumber: { 1 },
            reducer: reducer.reduce
        )
    }
    
    @Test("Test send events")
    func testSend() async throws {
        let expectedEvents = [
            SampleEvent.didStartLoading,
            .didChangeNumber(1),
            .didFinishLoading,
        ]
        presenter.send(.increase)
        await reducer.expectEvents(expectedEvents, timeout: 0.1)
    }
}
