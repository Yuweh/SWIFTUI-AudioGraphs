//
//  StationInfo.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//
import SwiftUI

struct StationInfo: View {
  var station: WeatherStation

  init(station: WeatherStation) {
    self.station = station
    UITabBar.appearance().backgroundColor = .white
  }

  var body: some View {
    VStack {
      StationHeader(station: self.station)
        .padding()
      TabView {
        TemperatureTab(station: self.station)
          .tabItem {
            Image(systemName: "thermometer")
            Text("Temperatures")
          }
        SnowfallTab(station: self.station)
          .tabItem {
            Image(systemName: "snow")
            Text("Snowfall")
          }
        PrecipitationTab(station: self.station)
          .tabItem {
            Image(systemName: "cloud.rain")
            Text("Precipitation")
          }
      }
    }.navigationBarTitle(Text("\(station.name)"), displayMode: .inline)
  }
}

struct StationInfo_Previews: PreviewProvider {
  static var previews: some View {
    StationInfo(station: WeatherInformation().stations[0])
  }
}
