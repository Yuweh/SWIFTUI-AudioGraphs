//
//  Extensions.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import Foundation

extension Double {
  var asLatitude: String {
    let deg = floor(self)
    let min = fabs(self.truncatingRemainder(dividingBy: 1) * 60.0).rounded()
    if self > 0 {
      return String(format: "%.f° %.f\" N", deg, min)
    } else if self < 0 {
      return String(format: "%.f° %.f\" S", -deg, min)
    }

    return "0°"
  }

  var asLongitude: String {
    let deg = floor(self)
    let min = fabs(self.truncatingRemainder(dividingBy: 1) * 60.0).rounded()
    if self > 0 {
      return String(format: "%.f° %.f\" E", deg, min)
    } else if self < 0 {
      return String(format: "%.f° %.f\" W", -deg, min)
    }

    return "0°"
  }
}

extension Int {
  var monthAbbreviation: String {
    let shortMonthSymbols = Calendar.current.shortMonthSymbols
    return shortMonthSymbols[self]
  }

  var monthName: String {
    let monthSymbols = Calendar.current.monthSymbols
    return monthSymbols[self]
  }
}
