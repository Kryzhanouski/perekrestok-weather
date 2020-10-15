//
//  Condition+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

@objc(Condition)
public class Condition: NSManagedObject, Decodable {
    enum ConditionKeys: CodingKey {
        case code, temperature, text
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: ConditionKeys.self)
        code = try container.decode(Int16.self, forKey: .code)
        temperature = try container.decode(Int16.self, forKey: .temperature)
        text = try container.decode(String.self, forKey: .text)
    }
}
