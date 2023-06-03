//
//  WeatherViewModel.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

class WeatherViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: Weather?
    var weathers: Observable<Weather> = Observable(nil)
    
    func validate(latitude: String, longitude: String) -> Bool {
        if latitude.isEmpty || longitude.isEmpty {
            return false
        }
        return true
    }
    
    func getWeatherData(lati: String, longi: String) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        APICaller.getWeatherDataFromServer(latitude: lati, longitude: longi) { [weak self] result in
            self?.isLoadingData.value = false
            
            switch result {
            case .success(let weatherData):
                print("weathers Data: ", weatherData)
                self?.dataSource = weatherData
                self?.mapWeatherData()
            case .failure(let error):
                print("weathers error:", error)
                self?.dataSource = nil
                self?.mapWeatherData()
            }
        }
    }
    
    private func mapWeatherData() {
        weathers.value = self.dataSource
    }
}
