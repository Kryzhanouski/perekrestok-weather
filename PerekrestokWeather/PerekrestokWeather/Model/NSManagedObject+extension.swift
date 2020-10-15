//
//  NSManagedObject+extension.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/12/20.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

extension NSManagedObject {

    // Returns the unqualified class name, i.e. the last component.
    // Can be overridden in a subclass.
    class func entityName() -> String {
        return String(describing: self)
    }

    convenience init(context: NSManagedObjectContext) {
        let eName = type(of: self).entityName()
        let entity = NSEntityDescription.entity(forEntityName: eName, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
