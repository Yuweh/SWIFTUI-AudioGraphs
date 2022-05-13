//
//  StationHeader.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct StationHeader: View {
  var station: WeatherStation

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("Latitude: \(station.coordinates.latitude.asLatitude)")
        Text("Longitude: \(station.coordinates.longitude.asLongitude)")
        Text("Elevation: \(station.altitude.formatted())")
      }
      Spacer()
      MapView(coordinates: station.coordinates)
        .frame(width: 200, height: 200)
    }
  }
}

struct StationHeader_Previews: PreviewProvider {
  static var previews: some View {
    StationHeader(station: WeatherInformation().stations[1])
  }
}
