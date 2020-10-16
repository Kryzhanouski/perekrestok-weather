//
//  WeatherService.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/12/20.
//
import CoreData
import Foundation

/// The possible errors returned by the `WeatherService`
///
/// - apiError: wrapper around an api error. The `underlingError` contains the api error
enum WeatherServiceError: Error {
    case apiError(underlingError: Error?)
}

struct WeatherServiceResult {
    /** locations */
    let locations: [Location]
    /** Data are returned from cache or from backend */
    let cached: Bool
}

/// This Serivice is used for getting locations weather data . All methods are async and provide a completion callback that is called after the action has been performed.
///
protocol WeatherService {

    typealias RequestID = TimeInterval

    /// The `Result` parameter contains the Locations in the success case and a `WeatherServiceError` if something went wrong
    /// The `Double` parameter contains the request identifier
    typealias resultCallback = (Result<WeatherServiceResult, WeatherServiceError>, RequestID) -> Void

    /// Async method to get locations data
    /// - Parameters:
    ///   - completion: The `Result` parameter contains the feeds array in the success case and a `WeatherServiceError` if something went wrong
    /// - Returns: request identifier that can be used to identify request in callback
    @discardableResult
    func fetchWeatherByLocations(completion: @escaping WeatherService.resultCallback) -> RequestID

    /// Method to add new location
    /// - Parameters:
    ///   - name: location name
    func addNewLocation(name: String) throws

    /// Method to remove location
    /// - Parameters:
    ///   - location: location
    func removeLocation(_ location: Location) throws

}


class WeatherServiceImpl: WeatherService {

    private let context = DependencyModule.resolve(NSManagedObjectContext.self)

    internal init() {
    }

    @discardableResult
    func fetchWeatherByLocations(completion: @escaping (Result<WeatherServiceResult, WeatherServiceError>, TimeInterval) -> Void) -> RequestID {
        let requestId = Date.timeIntervalSinceReferenceDate
        
        guard let locations = try? context.fetch(Location.fetchRequest()) as? [Location] else {
            DispatchQueue.main.async {
                completion(.success(WeatherServiceResult(locations: [], cached: false)), requestId)
            }
            return requestId
        }

        completion(.success(WeatherServiceResult(locations: locations.sorted(by: { $0.city ?? "" < $1.city ?? "" }), cached: true)), requestId)
        
        let group = DispatchGroup()
        var results: [Result<Location, WeatherServiceError>] = []
        
        for location in locations {
            guard let city = location.city else {
                continue
            }
            group.enter()
            fetchWeatherLorLocation(location: city) { result in
                results.append(result)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            let result = self.merge(locations: locations, results: results)
            do {
                try self.context.save()
                completion(result, requestId)
            }
            catch {
                completion(.failure(self.handleRequestError(error: error)), requestId)
            }
        }

        return requestId
    }
    
    func addNewLocation(name: String) throws {
        let location = Location(context: context)
        location.city = name
        try? context.save()
    }
    
    func removeLocation(_ location: Location) throws {
        context.delete(location)
        try? context.save()
    }
}

extension WeatherServiceImpl {
    private func fetchWeatherLorLocation(location: String, completion: @escaping (Result<Location, WeatherServiceError>) -> Void) {
        YahooWeatherAPI.shared.weather(location: location , failure: { (error) in
            print(error.localizedDescription)
            completion(.failure(self.handleRequestError(error: error)))
        }, success: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.context
                let location = try jsonDecoder.decode(Location.self, from: response.data)
                completion(.success(location))
                try print(response.jsonObject())
            } catch {
                print(error.localizedDescription)
                completion(.failure(self.handleRequestError(error: error)))
            }
        },
        unit: .metric)
    }

    private func merge(locations:[Location], results:[Result<Location, WeatherServiceError>]) -> Result<WeatherServiceResult, WeatherServiceError> {
        let firstFailure = results.first {
            if case .failure = $0 {
                return true
            }
            return false
        }

        if case .failure(let error) = firstFailure {
            return .failure(error)
        }
        
        let newLocations: [Location] = results.compactMap {
            if case .success(let location) = $0 {
                return location
            }
            return nil
        }
        
        locations.forEach { context.delete($0) }
        
        return .success(WeatherServiceResult(locations: newLocations.sorted(by: { $0.city ?? "" < $1.city ?? "" }), cached: false))
    }
    
    private func handleRequestError(error: Error?) -> WeatherServiceError {
        let error = WeatherServiceError.apiError(underlingError: error)
        return error
    }
}


