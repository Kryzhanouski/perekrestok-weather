//
//  Atmosphere+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

@objc(Atmosphere)
public class Atmosphere: NSManagedObject, Decodable {
    
    enum AtmosphereKeys: CodingKey {
        case humidity, visibility, pressure
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: AtmosphereKeys.self)
        humidity = try container.decode(Int16.self, forKey: .humidity)
        visibility = try container.decode(Float.self, forKey: .visibility)
        pressure = try container.decode(Float.self, forKey: .pressure)
    }


}
