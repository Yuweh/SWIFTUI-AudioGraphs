//
//  PrecipitationTab.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct PrecipitationTab: View {
  var station: WeatherStation

  var body: some View {
    VStack {
      Text("Precipitation for 2018")
      PrecipitationChart(measurements: station.measurements)
        .accessibilityLabel("A chart showing Precipitations for 2018")
    }
  }
}

struct PrecipitationTab_Previews: PreviewProvider {
  static var previews: some View {
    PrecipitationTab(station: WeatherInformation().stations[2])
  }
}
