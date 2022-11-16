//
//  SearchRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 14/11/2022.
//

import XCTest
@testable import Reciplease

final class SearchRepositoryTests: XCTestCase {

    func testWhenResponsesReturnedIsSuccess() {
        let expectation = self.expectation(description: "Returned response")
        let client = MockHttpClient(responses: .success)
        let repository = SearchRepository(client: client)

        
        repository.getRecipe(
            for: [],
            callback: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.hits.count, 20)
                case .failure(_):
                    XCTFail()
                }
            
                expectation.fulfill()
            }
        )

        waitForExpectations(timeout: 1.0)
    }
    
    func testWhenResponsesReturnedIsFailure() {
        let expectation = self.expectation(description: "Returned response")
        let client = MockHttpClient(responses: .failure)
        let repository = SearchRepository(client: client)

        
        repository.getRecipe(
            for: [],
            callback: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.hits.count, 20)
                case .failure(let error):
                    XCTAssertEqual(MockHttpClient.Responses.MockError.mock, error as! MockHttpClient.Responses.MockError)
                }
            
                expectation.fulfill()
            }
        )

        waitForExpectations(timeout: 1.0)
    }
}


final class MockHttpClient: HTTPClientType {
    let responses: Responses

    init(responses: Responses) {
        self.responses = responses
    }

    struct Responses {
        var onSend: Result<Data, Error>
    }

    func send(
        request: URLRequest,
        token: Reciplease.RequestCancellationToken,
        completionHandler: @escaping (Result<Data, Error>) -> Void) {
            completionHandler(responses.onSend)
    }
}

private extension MockHttpClient.Responses {
    static var success: MockHttpClient.Responses {
        .init(onSend: .success(MockData.recipeData))
    }

    static var failure: MockHttpClient.Responses {
        return .init(
            onSend: .failure(MockError.mock)
        )
    }
    
    enum MockError: Error {
        case mock
    }
}
