//
//  Astronomy+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/15/20.
//
//

import Foundation
import CoreData

@objc(Astronomy)
public class Astronomy: NSManagedObject, Decodable {
    
    enum AstronomyKeys: CodingKey {
        case sunset
        case sunrise
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: AstronomyKeys.self)
        sunrise = try container.decode(String.self, forKey: .sunrise)
        sunset = try container.decode(String.self, forKey: .sunset)
    }

}
