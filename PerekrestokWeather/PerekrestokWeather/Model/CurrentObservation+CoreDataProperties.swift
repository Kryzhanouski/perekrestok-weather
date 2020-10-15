//
//  CurrentObservation+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension CurrentObservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentObservation> {
        return NSFetchRequest<CurrentObservation>(entityName: "CurrentObservation")
    }

    @NSManaged public var condition: Condition?
    @NSManaged public var wind: Wind?
    @NSManaged public var atmosphere: Atmosphere?
    @NSManaged public var astronomy: Astronomy?

}

extension CurrentObservation : Identifiable {

}
