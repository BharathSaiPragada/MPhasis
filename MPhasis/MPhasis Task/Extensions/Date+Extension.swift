//
//  Date+Extension.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import Foundation


extension Int {
    func convertToDate() -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss SSS"
//        return formatter.date(from: self.description)
        
        // convert Int to TimeInterval (typealias for Double)
        let timeInterval = TimeInterval(self)

        // create NSDate from Double (NSTimeInterval)
        return Date(timeIntervalSince1970: timeInterval)
    }
}

extension Date {
    func convertToString(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
