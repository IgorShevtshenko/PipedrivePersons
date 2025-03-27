import Testing
@testable import ArchitectureKit

struct ReducerTests {

    @Test("Reduce state")
    func testReduce() async throws {
        let resultState = SampleReducer.reduce(state: .init(count: 0), event: .didChangeNumber(2))
        #expect(resultState == SampleState(count: 2))
    }
}
