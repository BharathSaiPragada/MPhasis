//
//  CustomTableCellViewModel.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

class CustomTableCellViewModel {
    var name: String
    var lat: Double
    var lon: Double
    var country: String
    var state: String?
    
    init(countryData: Country) {
        self.name = countryData.name
        self.lat = countryData.lat
        self.lon = countryData.lon
        self.country = countryData.country
        self.state =  countryData.state
    }
}
