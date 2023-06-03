//
//  ContriesModel.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

// MARK: - Country
class Country: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }

    init(name: String, localNames: [String: String]?, lat: Double, lon: Double, country: String, state: String) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
}

typealias Countries = [Country]
