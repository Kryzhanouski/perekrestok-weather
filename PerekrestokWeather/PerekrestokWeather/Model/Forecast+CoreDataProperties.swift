//
//  Forecast+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var day: String?
    @NSManaged public var date: Date?
    @NSManaged public var low: Int16
    @NSManaged public var high: Int16
    @NSManaged public var text: String?
    @NSManaged public var code: Int16

}

extension Forecast : Identifiable {

}
