//
//  MapView.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  var coordinates: CLLocationCoordinate2D

  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    let coordinate = CLLocationCoordinate2D(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    view.setRegion(region, animated: true)
    view.mapType = .hybrid
    view.isScrollEnabled = false
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(
      coordinates: CLLocationCoordinate2D(
        latitude: 34.011286,
        longitude: -116.166868
      )
    )
  }
}
