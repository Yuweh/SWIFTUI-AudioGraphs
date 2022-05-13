//
//  DayInfo.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import Foundation

struct DayInfo: Identifiable {
  var date: Date
  var precipitation: Measurement<UnitLength>
  var snowfall: Measurement<UnitLength>
  var high: Measurement<UnitTemperature>
  var low: Measurement<UnitTemperature>

  var id: Date {
    return date
  }

  var dateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d/yyyy"
    return dateFormatter.string(from: date)
  }
}
