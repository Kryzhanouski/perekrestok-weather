//
//  Location+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

enum TopLevelKeys: CodingKey {
    case location
    case current_observation
    case forecasts
}

@objc(Location)
public class Location: NSManagedObject, Decodable {
    enum LocationKeys: CodingKey {
        case city
        case country
        case lat
        case long
        case region
        case timezone_id
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        city = try locationContainer.decode(String.self, forKey: .city)
        country = try locationContainer.decode(String.self, forKey: .country)
        lat = try locationContainer.decode(Double.self, forKey: .lat)
        long = try locationContainer.decode(Double.self, forKey: .long)
        region = try locationContainer.decode(String.self, forKey: .region)
        timezone_id = try locationContainer.decode(String.self, forKey: .timezone_id)
        let forecastsArray = try container.decode([Forecast].self, forKey: .forecasts)
        forecasts = NSOrderedSet(array: forecastsArray)
        currentObservation = try container.decode(CurrentObservation.self, forKey: .current_observation)
    }
}
