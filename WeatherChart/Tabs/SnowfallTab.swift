//
//  SnowfallTab.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct SnowfallTab: View {
  var station: WeatherStation

  var body: some View {
    VStack {
      Text("Snowfall for 2018")
      SnowfallChart(snowfall: station.measurements.filter { $0.snowfall.value > 0.0 })
    }
  }
}

struct SnowfallTab_Previews: PreviewProvider {
  static var previews: some View {
    SnowfallTab(station: WeatherInformation().stations[2])
  }
}
