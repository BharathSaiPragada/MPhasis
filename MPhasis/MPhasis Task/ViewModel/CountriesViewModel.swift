//
//  CountriesViewModel.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

class CountriesViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: Countries?
    var countries: Observable<[CustomTableCellViewModel]> = Observable(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func validate(countryTF: String, state: String) -> Bool {
        if !countryTF.isEmpty || !state.isEmpty {
            return true
        }
        return false
    }
    
    func getEndPoint(countryTF: String, state: String) -> String {
        var endPoint = ""
        if !countryTF.isEmpty {
            endPoint = countryTF
            if !state.isEmpty {
                endPoint = endPoint+","+state
            }
        } else if !state.isEmpty {
            endPoint = state
        }
        return endPoint
    }
        
    func getCountriesData(countryQuery: String) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        APICaller.getCountryDataFromServer(CountryName: countryQuery) { [weak self] result in
            self?.isLoadingData.value = false
            
            switch result {
            case .success(let countriesData):
                print("weathers count: ", countriesData)
                self?.dataSource = countriesData
                self?.mapWeatherData()
            case .failure(let error):
                print("weathers error:", error)
                self?.dataSource = nil
                self?.mapWeatherData()
            }
        }
    }
    
    private func mapWeatherData() {
        countries.value = self.dataSource?.compactMap({CustomTableCellViewModel(countryData: $0)})
    }
}
