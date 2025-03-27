import Testing
import Networking
@testable import NetworkingImpl

struct EndpointConfigurationTests {

    @Test("Test correct url")
    func testCorrectUrl() async throws {
        let configuration = EndpointConfigurationImpl()
        let url = await configuration.url(
            applying: "persons",
            queryItems: [
                .init(name: "sort_by", value: "id")
            ]
        )
        #expect(url?.absoluteString == "https://api.pipedrive.com/api/v2/persons?sort_by=id")
    }
}
