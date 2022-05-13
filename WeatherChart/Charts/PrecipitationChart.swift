//
//  PrecipitationChart.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct PrecipitationChart: View {
  var measurements: [DayInfo]

  func sumPrecipitation(_ month: Int) -> Measurement<UnitLength> {
    self.measurements
      .filter {
        Calendar.current.component(.month, from: $0.date) == month + 1
      }
      .reduce(Measurement<UnitLength>(value: 0, unit: .inches)) { $0 + $1.precipitation }
  }

  func formatted(precipitation: Measurement<UnitLength>) -> String {
    String(format: "%.1f", precipitation.value)
  }

  var body: some View {
    HStack {
      ForEach(0..<12) { monthIndex in
        VStack {
          Spacer()
          Text(formatted(precipitation: sumPrecipitation(monthIndex)))
            .font(.footnote)
            .rotationEffect(.degrees(-90))
            .offset(y: sumPrecipitation(monthIndex).value < 2.4 ? 0 : 35)
            .zIndex(1)
          Rectangle()
            .fill(Color.green)
            .frame(width: 20, height: CGFloat(sumPrecipitation(monthIndex).value) * 15.0)
          Text("\(monthIndex.monthAbbreviation)")
            .font(.footnote)
            .frame(height: 20)
        }
      }
    }
  }
}

struct PrecipitationChart_Previews: PreviewProvider {
  static var previews: some View {
    PrecipitationChart(measurements: WeatherInformation().stations[2].measurements)
  }
}
