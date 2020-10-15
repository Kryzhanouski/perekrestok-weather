//
//  ConditionCode.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/15/20.
//

import Foundation

enum ConditionCode: Int {
    case tornado = 0
    case tropicalStorm = 1
    case hurricane = 2
    case severeThunderstorms = 3
    case thunderstorms = 4
    case mixedRainAndSnow = 5
    case mixedRainAndSleet = 6
    case mixedSnowSndSleet = 7
    case freezingDrizzle = 8
    case drizzle = 9
    case freezingRain = 10
    case showers = 11
    case rain = 12
    case snowFlurries = 13
    case lightSnowShowers = 14
    case blowingSnow = 15
    case snow = 16
    case hail = 17
    case sleet = 18
    case dust = 19
    case foggy = 20
    case haze = 21
    case smoky = 22
    case blustery = 23
    case windy = 24
    case cold = 25
    case cloudy = 26
    case mostlyCloudyNight = 27
    case mostlyCloudyDay = 28
    case partlyCloudyNight = 29
    case partlyCloudyDay = 30
    case clearNight = 31
    case sunny = 32
    case fairNight = 33
    case fairDay = 34
    case mixedRainAndHail = 35
    case hot = 36
    case isolatedThunderstorms = 37
    case scatteredThunderstorms = 38
    case scatteredShowersDay = 39
    case heavyRain = 40
    case scatteredSnowShowersDay = 41
    case heavySnow = 42
    case blizzard = 43
    case notAvailable = 44
    case scatteredShowersNight = 45
    case scatteredSnowShowersNight = 46
    case scatteredThundershowers = 47
    
    func imageName() -> String {
        let name: String
        switch self {
        case .tornado:
            name = "T-Storms"
        case .tropicalStorm:
            name = "T-Storms"
        case .hurricane:
            name = "T-Storms"
        case .severeThunderstorms:
            name = "T-Storms"
        case .thunderstorms:
            name = "T-Storms"
        case .mixedRainAndSnow:
            name = "Rain and Snow"
        case .mixedRainAndSleet:
            name = "Sleet"
        case .mixedSnowSndSleet:
            name = "Sleet"
        case .freezingDrizzle:
            name = "Freezing Rain"
        case .drizzle:
            name = "Freezing Rain"
        case .freezingRain:
            name = "Freezing Rain"
        case .showers:
            name = "Showers"
        case .rain:
            name = "Rain"
        case .snowFlurries:
            name = "Flurries"
        case .lightSnowShowers:
            name = "Mostly Cloudy w: Showers"
        case .blowingSnow:
            name = "Snow"
        case .snow:
            name = "Snow"
        case .hail:
            name = "Snow"
        case .sleet:
            name = "Sleet"
        case .dust:
            name = "Fog"
        case .foggy:
            name = "Fog"
        case .haze:
            name = "Hazy Sunshine"
        case .smoky:
            name = "Fog"
        case .blustery:
            name = "Windy"
        case .windy:
            name = "Windy"
        case .cold:
            name = "Cold"
        case .cloudy:
            name = "Cloudy"
        case .mostlyCloudyNight:
            name = "Partly Cloudy"
        case .mostlyCloudyDay:
            name = "Mostly Cloudy"
        case .partlyCloudyNight:
            name = "Partly Cloudy"
        case .partlyCloudyDay:
            name = "Mostly Cloudy"
        case .clearNight:
            name = "Mostly Clear"
        case .sunny:
            name = "Sunny"
        case .fairNight:
            name = "Clear"
        case .fairDay:
            name = "Sunny"
        case .mixedRainAndHail:
            name = "Rain and Snow"
        case .hot:
            name = "Hot"
        case .isolatedThunderstorms:
            name = "T-Storms"
        case .scatteredThunderstorms:
            name = "T-Storms"
        case .scatteredShowersDay:
            name = "Showers"
        case .heavyRain:
            name = "Rain"
        case .scatteredSnowShowersDay:
            name = "Showers"
        case .heavySnow:
            name = "Snow"
        case .blizzard:
            name = "Snow"
        case .notAvailable:
            name = "Sunny"
        case .scatteredShowersNight:
            name = "Partly Cloudy w: Showers"
        case .scatteredSnowShowersNight:
            name = "Partly Cloudy w: Showers"
        case .scatteredThundershowers:
            name = "Partly Cloudy w: Showers"
        }
        return name
    }
}
