import XCTest
import Foundation
import SwiftyJSON
import SwiftHelpers

@testable import SwiftODOT

class TripCheckClientTests: XCTestCase {
    
    func testConformsToHTTPClient() {
        let expectation = self.expectation(description: "It conforms to the protocol")
        
        if TripCheckClient.self is HTTPClient.Type {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchDriveTimesOnSuccess() {
        let mockConfiguration = MockConfiguration.init()
        mockConfiguration.setStatusCode(200)
        mockConfiguration.setDataResponse(TestData.driveTimeDataJSON.data)
        mockConfiguration.setAPIURL(ServiceLocator.driveTimeConfig())
        let session = mockConfiguration.mockAPIResponse()

        let expectation = self.expectation(description: "The correct endpoint was called")
        guard let expectedJSON = try? JSON(data: TestData.driveTimeDataJSON.data) else { XCTFail("Failed to parse test JSON"); return }

        let client = TripCheckClient(
            sessionManager: session,
            serviceLocatorURL: ServiceLocator.driveTimeConfig()
        )
        
        client.onSuccess = { (actualResponse: JSON?) -> Void in
            XCTAssertNotNil(actualResponse)
            XCTAssertEqual(actualResponse, expectedJSON)
            expectation.fulfill()
        }
        client.onFailure = { (_: Int?, _: String?) -> Void in
            XCTFail("onFailure handler was not supposed to be called")
        }
        client.fetch()

        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchDriveTimesOnError() {
        let mockConfiguration = MockConfiguration.init()
        mockConfiguration.setStatusCode(400)
        mockConfiguration.setError("Bad Request")
        mockConfiguration.setDataResponse(TestData.driveTimeDataJSON.data)
        mockConfiguration.setAPIURL(ServiceLocator.driveTimeConfig())
        let session = mockConfiguration.mockAPIResponse()
        
        let expectation = self.expectation(description: "onError handler called")
        let client = TripCheckClient(
            sessionManager: session,
            serviceLocatorURL: ServiceLocator.driveTimeConfig()
        )
        client.onSuccess = { (_: JSON?) -> Void in
            XCTFail("onSuccess should not have been called")
        }
        client.onFailure = { (_: Int?, _: String? ) -> Void in
            expectation.fulfill()
        }
        client.fetch()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}
