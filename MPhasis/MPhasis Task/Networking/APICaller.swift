//
//  APICaller.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getWeatherDataFromServer(latitude: String,
                                         longitude: String,
                                         completionHandler: @escaping (_ result: Result<Weather, NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.serverAddress+NetworkConstants.shared.latitude+latitude+NetworkConstants.shared.longitude+longitude+NetworkConstants.shared.limit+NetworkConstants.shared.appid+NetworkConstants.shared.apiKey
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(Weather.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getCountryDataFromServer(CountryName: String,
                                         completionHandler: @escaping (_ result: Result<Countries, NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.serverAddress+NetworkConstants.shared.countries+CountryName+NetworkConstants.shared.limit+NetworkConstants.shared.appid+NetworkConstants.shared.apiKey
        print("urlString: ",urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(Countries.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
