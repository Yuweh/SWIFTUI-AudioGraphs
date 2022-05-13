//
//  TemperatureTab.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct TemperatureTab: View {
  var station: WeatherStation

  var body: some View {
    VStack {
      Text("Temperatures for 2018")
      TemperatureChart(measurements: station.measurements)
    }.padding()
  }
}

struct TemperatureTab_Previews: PreviewProvider {
  static var previews: some View {
    TemperatureTab(station: WeatherInformation().stations[0])
  }
}
