import Testing
import Foundation
import Networking
@testable import NetworkingImpl

struct NetworkClientTests {
    
    @Test("Success http status code")
    func testSuccessStatusCodes() async throws {
        let expectedString = "data"
        let networkClient = makeNetworkClient(
            onData: { _ in (Data(), MockHTTPURLResponse(code: 200)) },
            onDecode: { _ in expectedString }
        )
        let result = try await networkClient.execute(responseType: String.self)
        #expect(expectedString == result)
    }
    
    @Test("External error thrown on failure")
    func testExternalError() async throws {
        let expectedErrorCode = 1
        let networkClient = makeNetworkClient(
            onData: { _ in
                (
                    Data("""
                     {
                         "errorCode": \(expectedErrorCode)
                     }
                     """.utf8),
                    MockHTTPURLResponse(code: 400)
                )
            },
            onDecode: { _ in "data" }
        )
        await #expect(throws: NetworkError.externalError(expectedErrorCode)) {
            try await networkClient.execute(responseType: String.self)
        }
    }
    
    @Test("Internet connection failure")
    func testInternetConnectionFailure() async throws {
        let networkClient = makeNetworkClient(
            onData: { _ in
                throw URLError(.notConnectedToInternet)
            },
            onDecode: { _ in "data" }
        )
        await #expect(throws: NetworkError.noInternetConnection) {
            try await networkClient.execute(responseType: String.self)
        }
    }
    
    private func makeNetworkClient(
        onData: @escaping (URLRequest) async throws -> (Data, URLResponse),
        onDecode: @escaping (Data) throws -> Any
    ) -> NetworkClientImpl {
        NetworkClientImpl(
            urlSession: MockURLSession(onData: onData),
            requestSerializer: MockRequestSerializer(),
            responseSerializer: MockResponseSerializer(onDecode: onDecode),
            endpointConfiguration: MockEndpointConfiguration()
        )
    }
}

private extension NetworkClientImpl {
    
    func execute<ResponseType: Decodable>(responseType: ResponseType.Type) async throws(
        NetworkError
    ) -> ResponseType {
        try await execute(
            method: .get,
            path: "test",
            queryItems: [],
            body: EmptyRequestBody?.none,
            responseType: responseType
        )
    }
}
