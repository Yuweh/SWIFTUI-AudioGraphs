//
//  WeatherInformation.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import Foundation
import CoreLocation

class WeatherInformation {
  var stations: [WeatherStation]

  init() {
    // Init empty array
    stations = []

    // Converter for date string
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d/yyyy"

    // Get CSV data
    guard let csvData = getCsvAsString() else {
      fatalError("Failed to load csv file.")
    }

    var currentStationId = ""
    var currentStation: WeatherStation?
    // Parse each line
    csvData.enumerateLines { line, _ in
      let cols = line.components(separatedBy: ",")
      if currentStationId != cols[0] {
        if let newStation = currentStation {
          if newStation.name != "NAME" {
            self.stations.append(newStation)
          }
        }

        currentStationId = cols[0]
        let name = cols[1].replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ";", with: ",")
        let coordinates = CLLocationCoordinate2D(latitude: Double(cols[2]) ?? 0, longitude: Double(cols[3]) ?? 0)
        let alt = Measurement<UnitLength>(value: (Double(cols[4]) ?? 0), unit: .meters).converted(to: .feet)
        currentStation = WeatherStation(
          id: currentStationId,
          name: name,
          coordinates: coordinates,
          altitude: alt,
          measurements: [])
      }

      let date = dateFormatter.date(from: cols[5]) ?? Date()
      let precip = Measurement<UnitLength>(value: Double(cols[6]) ?? 0, unit: .inches)
      let snow = Measurement<UnitLength>(value: Double(cols[7]) ?? 0, unit: .inches)
      let high = Measurement<UnitTemperature>(value: Double(cols[8]) ?? 0, unit: .fahrenheit)
      let low = Measurement<UnitTemperature>(value: Double(cols[9]) ?? 0, unit: .fahrenheit)
      let newData = DayInfo(date: date, precipitation: precip, snowfall: snow, high: high, low: low)

      currentStation?.measurements.append(newData)
    }
    // Add the last station read
    if let newStation = currentStation {
      self.stations.append(newStation)
    }
  }

  func getCsvAsString() -> String? {
    guard let fileURL = Bundle.main.url(forResource: "weather-data", withExtension: "csv") else { return nil }
    do {
      let csvData = try String(contentsOf: fileURL)
      return csvData
    } catch {
      return nil
    }
  }
}
