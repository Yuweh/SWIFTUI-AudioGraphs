//
//  ContentView.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct ContentView: View {
  let stations = WeatherInformation()

  var body: some View {
    NavigationView {
      VStack {
        List(stations.stations) { station in
          NavigationLink(destination: StationInfo(station: station)) {
            Text("\(station.name)")
          }
        }
        Text("Source: https://www.ncdc.noaa.gov/cdo-web/datasets")
          .italic()
      }.navigationBarTitle(Text("Weather Stations"))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
