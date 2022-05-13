//
//  SnowfallChart.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct SnowfallChart: View {
  var snowfall: [DayInfo]

  var body: some View {
    List(snowfall.filter { $0.snowfall.value > 0.0 }) { measurement in
      HStack {
        Text("\(measurement.dateString)")
          .frame(width: 100, alignment: .trailing)
        ZStack(alignment: .leading) {
          ForEach(0..<17) { mark in
            Rectangle()
              .fill(mark % 5 == 0 ? Color.black : Color.gray)
              .offset(x: CGFloat(mark) * 10.0)
              .frame(width: 1.0)
              .zIndex(1)
          }
          Rectangle()
            .fill(Color.blue)
            .frame(width: CGFloat(measurement.snowfall.value * 10.0), height: 5.0)
        }
        Spacer()
        Text(measurement.snowfall.formatted())
      }
    }
  }
}

struct SnowfallChart_Previews: PreviewProvider {
  static var previews: some View {
    SnowfallChart(snowfall: WeatherInformation().stations[2].measurements)
  }
}
