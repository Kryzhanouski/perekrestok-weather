//
//  DependencyModule.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/13/20.
//

import Foundation
import Swinject
import CoreData
import UIKit

/// This Module is used for dependency injection in this app. Use the static `container` property to `resolve` dependencies where you need them.
class DependencyModule {
    
    /// Stores all the dependencies. Use `resolve` to get a dependency out.
    static let container = Container()
    
    
    /// add all the dependencies to the DI container. Should be called on app start
    static func bootstrap() {
        bootstrapServices()
        bootstrapCoreData()
    }
    
    /// Resolve a registered dependency.
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
        
    }
    
    // The services are registered with the container scope which only creates one instance that is then always used. (singleton like)
    private static func bootstrapServices() {
        container.register(WeatherService.self) { resolver in
            return WeatherServiceImpl()
            }.inObjectScope(.container)
    }

    private static func bootstrapCoreData() {
        container.register(NSManagedObjectContext.self) { resolver in
            return (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
            }.inObjectScope(.container)
    }
}

