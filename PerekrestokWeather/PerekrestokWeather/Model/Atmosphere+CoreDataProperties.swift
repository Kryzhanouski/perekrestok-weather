//
//  Atmosphere+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension Atmosphere {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Atmosphere> {
        return NSFetchRequest<Atmosphere>(entityName: "Atmosphere")
    }

    @NSManaged public var humidity: Int16
    @NSManaged public var visibility: Float
    @NSManaged public var pressure: Float

}

extension Atmosphere : Identifiable {

}
