//
//  Condition+CoreDataProperties.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData


extension Condition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condition> {
        return NSFetchRequest<Condition>(entityName: "Condition")
    }

    @NSManaged public var code: Int16
    @NSManaged public var temperature: Int16
    @NSManaged public var text: String?

}

extension Condition : Identifiable {

}
