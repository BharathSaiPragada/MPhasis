//
//  NetworkConstants.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation

class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    public var serverAddress: String {
        get {
            return "http://api.openweathermap.org/"
        }
    }
    
    public var iconAddress: String {
        get {
            return "https://openweathermap.org/img/wn/"
        }
    }
    
    public var apiKey: String {
        get {
            return "76e3847eef9fdf1a5b964e13bb5c21b4"
        }
    }
    
    public var countries: String {
        get {
            return "geo/1.0/direct?q="
        }
    }
    
    public var limit: String {
        get {
            return "&limit=5"
        }
    }
    
    public var appid: String {
        get {
            return "&appid="
        }
    }
    
    public var latitude: String {
        get {
            return "data/2.5/weather?lat="
        }
    }
    
    public var longitude: String {
        get {
            return "&lon="
        }
    }
}

