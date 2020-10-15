//
//  CurrentObservation+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

@objc(CurrentObservation)
public class CurrentObservation: NSManagedObject, Decodable {
    
    enum CurrentObservationKeys: CodingKey {
        case condition
        case wind
        case atmosphere
        case astronomy
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CurrentObservationKeys.self)
        condition = try container.decode(Condition.self, forKey: .condition)
        wind = try container.decode(Wind.self, forKey: .wind)
        atmosphere = try container.decode(Atmosphere.self, forKey: .atmosphere)
        astronomy = try container.decode(Astronomy.self, forKey: .astronomy)
    }
}
