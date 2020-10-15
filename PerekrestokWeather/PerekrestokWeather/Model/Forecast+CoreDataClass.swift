//
//  Forecast+CoreDataClass.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//
//

import Foundation
import CoreData

@objc(Forecast)
public class Forecast: NSManagedObject, Decodable {
    
    enum ForecastKeys: CodingKey {
        case day, date, low
        case high, text, code
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: ForecastKeys.self)
        day = try container.decode(String.self, forKey: .day)
        date = try container.decode(Date.self, forKey: .date)
        low = try container.decode(Int16.self, forKey: .low)
        high = try container.decode(Int16.self, forKey: .high)
        text = try container.decode(String.self, forKey: .text)
        code = try container.decode(Int16.self, forKey: .code)
    }
}
