//
//  PerekrestokWeatherTests.swift
//  PerekrestokWeatherTests
//
//  Created by Mark Kryzhanouski on 10/12/20.
//

import XCTest
import CoreData
@testable import PerekrestokWeather

class PerekrestokWeatherTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TestDependencyModule.bootstrap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelParsing() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testBundle = Bundle(for: type(of: self))
        guard let responsePath = testBundle.path(forResource: "response.txt", ofType: nil) else {
            XCTFail()
            return
        }
        let responseData = try Data(contentsOf: URL(fileURLWithPath: responsePath))
        let jsonDecoder = JSONDecoder()
        jsonDecoder.userInfo[CodingUserInfoKey.managedObjectContext] = TestDependencyModule.resolve(NSManagedObjectContext.self)
        let location = try jsonDecoder.decode(Location.self, from: responseData)
        XCTAssertEqual(location.city, "Sunnyvale")
        XCTAssertEqual(location.lat, 37.371609)
        XCTAssertEqual(location.long, -122.038254)
        XCTAssertEqual(location.currentObservation?.wind?.chill, 59)
        XCTAssertEqual(location.currentObservation?.atmosphere?.pressure, 29.68)
        XCTAssertEqual(location.currentObservation?.astronomy?.sunrise, "7:23 am")
        XCTAssertEqual(location.currentObservation?.condition?.text, "Scattered Showers")
        XCTAssertEqual(location.forecasts?.count, 10)
        if let forecast = location.forecasts?.array.first as? Forecast {
            XCTAssertEqual(forecast.code, 12)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
