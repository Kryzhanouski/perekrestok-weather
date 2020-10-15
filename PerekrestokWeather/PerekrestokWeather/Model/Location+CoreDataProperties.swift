//
//  Location+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var region: String?
    @NSManaged public var timezone_id: String?
    @NSManaged public var currentObservation: CurrentObservation?
    @NSManaged public var forecasts: NSOrderedSet?

}

// MARK: Generated accessors for forecasts
extension Location {

    @objc(insertObject:inForecastsAtIndex:)
    @NSManaged public func insertIntoForecasts(_ value: Forecast, at idx: Int)

    @objc(removeObjectFromForecastsAtIndex:)
    @NSManaged public func removeFromForecasts(at idx: Int)

    @objc(insertForecasts:atIndexes:)
    @NSManaged public func insertIntoForecasts(_ values: [Forecast], at indexes: NSIndexSet)

    @objc(removeForecastsAtIndexes:)
    @NSManaged public func removeFromForecasts(at indexes: NSIndexSet)

    @objc(replaceObjectInForecastsAtIndex:withObject:)
    @NSManaged public func replaceForecasts(at idx: Int, with value: Forecast)

    @objc(replaceForecastsAtIndexes:withForecasts:)
    @NSManaged public func replaceForecasts(at indexes: NSIndexSet, with values: [Forecast])

    @objc(addForecastsObject:)
    @NSManaged public func addToForecasts(_ value: Forecast)

    @objc(removeForecastsObject:)
    @NSManaged public func removeFromForecasts(_ value: Forecast)

    @objc(addForecasts:)
    @NSManaged public func addToForecasts(_ values: NSOrderedSet)

    @objc(removeForecasts:)
    @NSManaged public func removeFromForecasts(_ values: NSOrderedSet)

}

extension Location : Identifiable {

}
