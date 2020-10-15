//
//  YahooWeatherAPI.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/12/20.
//

import Foundation
import OAuthSwift

enum YahooWeatherAPIResponseType:String {
    case json = "json"
    case xml = "xml"
}

enum YahooWeatherAPIUnitType:String {
    case imperial = "f"
    case metric = "c"
}

fileprivate struct YahooWeatherAPIClientCredentials {
    let appId: String
    let clientId: String
    let clientSecret: String
}

class YahooWeatherAPI {
    // Configure the following with your values.
    private let credentials = YahooWeatherAPIClientCredentials(appId: "evLL2lOl",
                                                               clientId: "dj0yJmk9UTdqdTV0eE1STmo1JmQ9WVdrOVpYWk1UREpzVDJ3bWNHbzlNQT09JnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PWVm",
                                                               clientSecret: "82a9cc178106a258a492334431b0dc4a4aa2fb9b")
    
    private let url:String = "https://weather-ydn-yql.media.yahoo.com/forecastrss"
    private let oauth:OAuth1Swift?
 
    public static let shared = YahooWeatherAPI()
 
    private init() {
        self.oauth = OAuth1Swift(consumerKey: self.credentials.clientId, consumerSecret: self.credentials.clientSecret)
    }

    private var headers:[String:String] {
        return [
            "X-Yahoo-App-Id": self.credentials.appId
        ]
    }
    
    /// Requests weather data by location name.
    ///
    /// - Parameters:
    ///   - location: the name of the location, i.e. sunnyvale,ca
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    
    public func weather(location:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .imperial) {
        self.makeRequest(parameters: ["location":location, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
    }
    
    
    /// Requests weather data by woeid (Where on Earth ID)
    ///
    /// - Parameters:
    ///   - woeid: The location's woeid
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    
    public func weather(woeid:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .imperial) {
        self.makeRequest(parameters: ["woeid":woeid, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
    }
    
    
    /// Requests weather data by latitude and longitude
    ///
    /// - Parameters:
    ///   - lat: latitude
    ///   - lon: longiture
    ///   - failure: failure callback
    ///   - success: success callback
    ///   - responseFormat: .xml or .json. default is .json.
    ///   - unit: metric or imperial units. default = .imperial
    public func weather(lat:String, lon:String, failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void, responseFormat:YahooWeatherAPIResponseType = .json, unit:YahooWeatherAPIUnitType = .imperial) {
        self.makeRequest(parameters: ["lat":lat, "lon":lon, "format":responseFormat.rawValue, "u":unit.rawValue], failure: failure, success: success)
    }
    
    
    /// Performs the API request with the OAuthSwift client
    ///
    /// - Parameters:
    ///   - parameters: Any URL parameters to pass to the endpoint.
    ///   - failure: failure callback
    ///   - success: success callback
    private func makeRequest(parameters:[String:String], failure: @escaping (_ error: OAuthSwiftError) -> Void, success: @escaping (_ response: OAuthSwiftResponse) -> Void) {
        self.oauth?.client.request(self.url, method: .GET, parameters: parameters, headers: self.headers, body: nil, checkTokenExpiration: true, completionHandler: { (result) in
            switch result {
                case .success(let response):
                    print(response)
                    success(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure(error)
            }
        })
    }
    
}
