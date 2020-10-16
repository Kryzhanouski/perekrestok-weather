//
//  WeatherServiceTest.swift
//  PerekrestokWeatherTests
//
//  Created by Mark Kryzhanouski on 10/16/20.
//

import XCTest
@testable import PerekrestokWeather

class WeatherServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TestDependencyModule.bootstrap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewLocation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let service = TestDependencyModule.resolve(WeatherService.self)
        try service.addNewLocation(name: "Barcelona")
    }

    func testDeleteLocation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let service = TestDependencyModule.resolve(WeatherService.self)
        try service.addNewLocation(name: "Barcelona")
        let expectation = XCTestExpectation(description: "Fetch")
        var locations: [Location]?
        service.fetchWeatherByLocations { (result, id) in
            if case .success(let response) = result,
               response.cached == false {
                locations = response.locations
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(locations)
        try service.removeLocation(locations![0])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
