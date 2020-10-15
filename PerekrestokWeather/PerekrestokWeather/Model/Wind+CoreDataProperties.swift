//
//  Wind+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension Wind {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wind> {
        return NSFetchRequest<Wind>(entityName: "Wind")
    }

    @NSManaged public var chill: Int16
    @NSManaged public var direction: Int16
    @NSManaged public var speed: Float

}

extension Wind : Identifiable {

}
