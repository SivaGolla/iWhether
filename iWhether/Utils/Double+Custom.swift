//
//  Double+Custom.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 05/10/24.
//

import Foundation

extension Double {
    var formattedHour: String {
        return DateFormatter.wTime.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    var formattedDay: String {
        return DateFormatter.wDay.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    var formattedDayValue: String {
        return DateFormatter.wDateValue.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
    
    var formattedTemperature: String {
        return String(format: "%1.0f", self)
    }
}
