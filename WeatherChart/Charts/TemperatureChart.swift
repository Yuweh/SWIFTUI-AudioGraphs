//
//  TemperatureChart.swift
//  WeatherChart
//
//  Created by Jay Bergonia on 5/13/22.
//

import SwiftUI

struct TemperatureChart: View {
  var measurements: [DayInfo]

  let tempGradient = Gradient(colors: [
    .purple,
    Color(red: 0, green: 0, blue: 139.0 / 255.0),
    .blue,
    Color(red: 30.0 / 255.0, green: 144.0 / 255.0, blue: 1.0),
    Color(red: 0, green: 191 / 255.0, blue: 1.0),
    Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0),
    .green,
    .yellow,
    .orange,
    Color(red: 1.0, green: 140.0 / 255.0, blue: 0.0),
    .red,
    Color(red: 139.0 / 255.0, green: 0.0, blue: 0.0)
  ])

  func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
    height / CGFloat(range)
  }

  func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
    width / CGFloat(count)
  }

  func dayOffset(_ date: Date, dWidth: CGFloat) -> CGFloat {
    guard let dateInDays = Calendar.current.ordinality(of: .day, in: .year, for: date) else {
      return 0
    }
    return CGFloat(dateInDays) * dWidth
  }

  func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
    CGFloat(temperature + 10) * degreeHeight
  }

  func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
    height - self.tempOffset(
      Double(line * 10),
      degreeHeight: self.degreeHeight(height, range: 110)
    )
  }

  func offsetFirstOfMonth(_ month: Int, width: CGFloat) -> CGFloat {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/d/yyyy"
    let date = dateFormatter.date(from: "\(month + 1)/1/2018") ?? Date()
    let dayWidth = self.dayWidth(width, count: 365)
    return self.dayOffset(date, dWidth: dayWidth)
  }

  var body: some View {
    Canvas { context, size in
      let shading = GraphicsContext.Shading.linearGradient(
        self.tempGradient,
        startPoint: .init(x: 0.0, y: size.height),
        endPoint: .init(x: 0.0, y: 0.0)
      )
      for measurement in measurements {
        let path = Path { path in
          let dWidth = self.dayWidth(size.width, count: 365)
          let dHeight = self.degreeHeight(size.height, range: 110)
          let dOffset = self.dayOffset(measurement.date, dWidth: dWidth)
          let lowOffset = self.tempOffset(measurement.low.value, degreeHeight: dHeight)
          let highOffset = self.tempOffset(measurement.high.value, degreeHeight: dHeight)
          path.move(to: .init(x: dOffset, y: size.height - lowOffset))
          path.addLine(to: .init(x: dOffset, y: size.height - highOffset))
        }
        context.stroke(path, with: shading)
      }
      for line in -1..<11 {
        let y = self.tempLabelOffset(line, height: size.height)
        let path = Path { path in
          path.move(to: CGPoint(x: 0, y: y))
          path.addLine(to: CGPoint(x: size.width, y: y))
        }
        context.stroke(path, with: line == 0 ? .color(.black) : .color(.gray))
        if line >= 0 {
          let temp = Measurement<UnitTemperature>(value: Double(line * 10), unit: .fahrenheit)
          let text = Text(temp.formatted(.measurement(width: .abbreviated, usage: .asProvided)))
          context.draw(text, at: CGPoint(x: 10, y: y), anchor: .leading)
        }
      }
      for monthIndex in 0..<12 {
        let dOffset = self.offsetFirstOfMonth(monthIndex, width: size.width)
        let path = Path { path in
          path.move(to: CGPoint(x: dOffset, y: size.height))
          path.addLine(to: CGPoint(x: dOffset, y: 0))
        }
        context.stroke(path, with: .color(.gray))
        let text = Text("\(monthIndex.monthAbbreviation)")
          .font(.subheadline)
        let textLocation = CGPoint(x: dOffset + 2, y: size.height - 25.0)
        context.draw(text, at: textLocation)
      }
    }
  }
}

extension TemperatureChart: AXChartDescriptorRepresentable {
  private var temperatureChartTitle: String {
    let sortedMeasurements = measurements.sorted {
      $0.date < $1.date
    }
    if
      let firstDay = sortedMeasurements.first?.date.formatted(date: .long, time: .omitted),
      let lastDay = sortedMeasurements.last?.date.formatted(date: .long, time: .omitted) {
      return "Temperature from \(firstDay) to \(lastDay)"
    }
    return "Temperature"
  }

  private var temperatureChartSummary: String {
    "\(measurements.count) measurements of temperature consisting of two data series. " +
    "One data series shows the low temperatures, the other the high temperatures."
  }

  func makeChartDescriptor() -> AXChartDescriptor {
    AXChartDescriptor(
      title: temperatureChartTitle,
      summary: temperatureChartSummary,
      xAxis: makeXAxisDescriptor(),
      yAxis: makeYAxisDescriptor(),
      series: makeDataSeriesDescriptor()
    )
  }

  private func makeXAxisDescriptor() -> AXNumericDataAxisDescriptor {
    AXNumericDataAxisDescriptor(
      title: "Measurements",
      range: 0...365,
      gridlinePositions: []) {
        "Day \(Int($0))"
    }
  }

  private func makeYAxisDescriptor() -> AXNumericDataAxisDescriptor {
    let maxTemperatureValue = measurements.map(\.high).max()?.value ?? 0.0
    return AXNumericDataAxisDescriptor(
      title: "Temperature",
      range: (0.0 ... maxTemperatureValue),
      gridlinePositions: []) {
        Measurement<UnitTemperature>(value: $0, unit: .fahrenheit).formatted()
    }
  }

  private func makeDataSeriesDescriptor() -> [AXDataSeriesDescriptor] {
    return []
  }
}

struct TemperatureChart_Previews: PreviewProvider {
  static var previews: some View {
    TemperatureChart(measurements: WeatherInformation().stations[2].measurements)
  }
}
