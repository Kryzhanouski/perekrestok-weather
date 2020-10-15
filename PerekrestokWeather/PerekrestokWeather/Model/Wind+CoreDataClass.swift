//
//  Wind+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

@objc(Wind)
public class Wind: NSManagedObject, Decodable {
    enum WindKeys: CodingKey {
        case chill, direction, speed
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: WindKeys.self)
        chill = try container.decode(Int16.self, forKey: .chill)
        direction = try container.decode(Int16.self, forKey: .direction)
        speed = try container.decode(Float.self, forKey: .speed)
    }
}
