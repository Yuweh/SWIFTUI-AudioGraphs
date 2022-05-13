//
//  WeatherStation.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import Foundation
import CoreLocation

struct WeatherStation: Identifiable {
  var id: String
  var name: String
  var coordinates: CLLocationCoordinate2D
  var altitude: Measurement<UnitLength>
  var measurements: [DayInfo]

  func measurementsInMonth(_ month: Int) -> [DayInfo] {
    return measurements.filter {
      return Calendar.current.component(.month, from: $0.date) == month
    }
  }

  var lowTemperatureForYear: Measurement<UnitTemperature> {
    let minTemperature = measurements.min { $0.low < $1.low }
    return minTemperature?.low ?? .init(value: Double.leastNormalMagnitude, unit: .fahrenheit)
  }

  var highTemperatureForYear: Measurement<UnitTemperature> {
    let maxTemperature = measurements.max { $0.high < $1.high }
    return maxTemperature?.high ?? .init(value: Double.greatestFiniteMagnitude, unit: .fahrenheit)
  }
}
