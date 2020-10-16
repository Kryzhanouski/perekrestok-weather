//
//  TestDependencyModule.swift
//  PerekrestokWeatherTests
//
//  Created by Mark Kryzhanouski on 10/16/20.
//

import Foundation
import Swinject
import CoreData
@testable import PerekrestokWeather


class TestDependencyModule {
    
    static let container = Container()
    
    static func bootstrap() {
        bootstrapServices()
        bootstrapCoreData()
    }
    
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
        
    }
    
    private static func bootstrapServices() {
        container.register(WeatherService.self) { resolver in
            return WeatherServiceImpl()
            }.inObjectScope(.container)
    }

    private static func bootstrapCoreData() {
        container.register(NSManagedObjectContext.self) { resolver in
            return self.persistentContainer.viewContext
            }.inObjectScope(.container)
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PerekrestokWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

