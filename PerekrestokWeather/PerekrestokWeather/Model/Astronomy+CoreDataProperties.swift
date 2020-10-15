//
//  Astronomy+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/15/20.
//
//

import Foundation
import CoreData


extension Astronomy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Astronomy> {
        return NSFetchRequest<Astronomy>(entityName: "Astronomy")
    }

    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?

}

extension Astronomy : Identifiable {

}
