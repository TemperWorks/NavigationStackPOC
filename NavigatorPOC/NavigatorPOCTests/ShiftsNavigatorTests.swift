//
//  ShiftsNavigatorTests.swift
//  NavigatorPOCTests
//
//  Created by Bruno Scheele on 10/06/2022.
//

import XCTest
@testable import NavigatorPOC

class ShiftsNavigatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
		let sut = ShiftsNavigator()
		
		sut.showJob(id: "foo")
		sut.startApplication(id: "foo")
		
		XCTAssert(sut.jobDetail?.jobId == "foo")
		XCTAssert(sut.shiftApplicationSkills?.shiftId == "foo")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
