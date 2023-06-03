//
//  CustomWeatherModel.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

class CustomWeatherModel {
    var name: String
    var lat: Double
    var lon: Double
    var country: String
    var description: String
    var icon: String
    var tempMin: Double
    var tempMax: Double
    var windSpeed: Double
    var sunRise: Int
    var sunSet: Int
    var iconURL: URL?
    
    init(weatherData: Weather) {
        self.name = weatherData.name
        self.lat = weatherData.coord.lat
        self.lon = weatherData.coord.lon
        self.country = weatherData.sys.country
        self.description = weatherData.weather[0].description
        self.icon = weatherData.weather[0].icon
        self.tempMin = weatherData.main.tempMin
        self.tempMax = weatherData.main.tempMax
        self.windSpeed = weatherData.wind.speed
        self.sunRise = weatherData.sys.sunrise
        self.sunSet = weatherData.sys.sunset
        let url = NetworkConstants.shared.iconAddress+weatherData.weather[0].icon+".png"
        self.iconURL = makeURLFromString(url)
    }
    private func makeURLFromString(_ imageCode: String) -> URL? {
        URL(string: imageCode)
    }
}
