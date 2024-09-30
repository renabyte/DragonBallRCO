//
//  DragonBallRCOTests.swift
//  DragonBallRCOTests
//
//  Created by Renato Calderon on 30/09/24.
//

import XCTest
@testable import DragonBallRCO

final class NetworkModelTests: XCTestCase {

    private var sut : NetworkModel!
    private var mock: ApliClientProtocolMock<[Bootcamps]>!
    
    override func setUp() {
        super.setUp()
        mock = ApliClientProtocolMock()
        sut = NetworkModel(client: mock)
    }
    
    func test_getAllBootcamps_success() {
        //Given
        let someResult = Result<[Bootcamps],NetworkError>.success([])
        mock.receiveResult = someResult
        var receivedResult: Result<[Bootcamps],NetworkError>?
        //When
        sut.getBootcamps{ result in
            receivedResult = result
        }
        //Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
}
