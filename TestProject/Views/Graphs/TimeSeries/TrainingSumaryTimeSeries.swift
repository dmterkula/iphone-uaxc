//
//  WeeklyTrainingSumaryTimeSeries.swift
//  UAXC
//
//  Created by David  Terkula on 12/23/22.
//

import SwiftUI
import Charts

struct TrainingSumaryTimeSeries: View, AXChartDescriptorRepresentable {
    
   
    @Binding var trainingWeeklySummaryDTOs: [TrainingSummaryDTO]
    @State var selectedElement: TrainingSummaryDTO?
    var chartFrequency: String
   
    @State var isOverview: Bool = false
    
    func makeChartDescriptor() -> AXChartDescriptor {
        return AccessibilityHelpers.chartDescriptor(trainingSummaryDTOs: trainingWeeklySummaryDTOs, chartFrequency: chartFrequency)
    }
    
    func getTitle() -> String {
       "Training Summary"
    }
    
    func getTimeFrame() -> String {
        "From: "
    }
    
    func getMarkLabel() -> String {
        if (chartFrequency == "monthly") {
            return "Month"
        } else if(chartFrequency == "weekly") {
            return "Week"
        } else {
            return "Day"
        }
    }
    
    func getXValues() -> [Date] {
      
        return trainingWeeklySummaryDTOs.map { $0.startDate }
       
    }
    
    private var xAxisStride: Calendar.Component {
        
        if (chartFrequency == "weekly") {
            return .day
        } else if(chartFrequency == "monthly") {
            return .month
        } else {
            // daily
            return .day
        }
    }
    
    private var xAxisStrideCount: Int {
        
        if (chartFrequency == "weekly") {
            return 7
        } else if (chartFrequency == "monthly)") {
            return 1
        } else {
            // daily
            return 1
        }
    }
    
    private func xAxisLabelFormatStyle(for date: Date) -> Date.FormatStyle {
        if (chartFrequency == "weekly") {
            return .dateTime.month(.abbreviated).day(.twoDigits)
        } else if(chartFrequency == "monthly") {
            return .dateTime.month(.abbreviated)
        } else {
            // daily
            return .dateTime.month(.abbreviated).day(.twoDigits)
        }
        
    }
    
    
    
    var body: some View {
        VStack {
            
            GroupBox (getTitle()) {
                
                VStack {
                    HStack {
                        
                        Text(getTimeFrame())
                        
                        Text(String(selectedElement!.startDate
                            .formatted(date: .abbreviated, time: .omitted))
                             + " - " + String(selectedElement!.endDate
                                .formatted(date: .abbreviated, time: .omitted)))
                    }
                    
                    HStack {
                        Text("Total Distance: ")
                        Text(String(selectedElement!.totalDistance))
                    }
                    
                    HStack {
                        Text("Avg Pace: ")
                        Text(selectedElement!.trainingAvgPace)
                    }
                    
                    HStack {
                        Text("Logged Runs: ")
                        Text(String(selectedElement!.runCount))
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                

                ScrollView(.horizontal) {
                    Chart {
                        
                        ForEach(trainingWeeklySummaryDTOs) {
                            var isSelected = $0.startDate == selectedElement!.startDate
                            LineMark(
                                x: .value(getMarkLabel(), $0.startDate, unit: .day),
                                y: .value("totalDistance", $0.totalDistance)
                            )
                            
                            PointMark(
                                x: .value(getMarkLabel(), $0.startDate, unit: .day),
                                y: .value("totalDistance", $0.totalDistance)
                            )
                            .foregroundStyle(isSelected ? .red : .blue)
                            
                        }
                    }.chartOverlay { proxy in
                        GeometryReader { geo in
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .gesture(
                                    SpatialTapGesture()
                                        .onEnded { value in
                                            let element = findElement(selectedElement: selectedElement, trainingWeeklySummaryDTOs: trainingWeeklySummaryDTOs, location: value.location, proxy: proxy, geometry: geo)
                                            selectedElement = element
                                        }
                                        .exclusively(
                                            before: DragGesture()
                                                .onChanged { value in
                                                    selectedElement = findElement(selectedElement: selectedElement, trainingWeeklySummaryDTOs: trainingWeeklySummaryDTOs, location: value.location, proxy: proxy, geometry: geo)
                                                }
                                        )
                                )
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: xAxisStride, count: xAxisStrideCount)) { date in
                            AxisValueLabel(format: xAxisLabelFormatStyle(for: date.as(Date.self) ?? Date()))
                        }
                    }
                    .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: trainingWeeklySummaryDTOs[0].startDate, upper: trainingWeeklySummaryDTOs[trainingWeeklySummaryDTOs.count - 1].endDate)))
                    
                    .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                    
                    .accessibilityChartDescriptor(self)
                    //                            .frame(height: isOverview ? Constants.previewChartHeight : Constants.detailChartHeight)
                    .frame(width: 200 + CGFloat((50 * trainingWeeklySummaryDTOs.count)))
                }
                

            }
        }
        // end chart vstack
    }
    
    private func findElement(selectedElement: TrainingSummaryDTO?, trainingWeeklySummaryDTOs: [TrainingSummaryDTO], location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> TrainingSummaryDTO? {
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
            if let date = proxy.value(atX: relativeXPosition) as Date? {
                // Find the closest date element.
                var minDistance: TimeInterval = .infinity
                var index: Int? = nil
                for weeklySummaryIndex in trainingWeeklySummaryDTOs.indices {
                    let nthSalesDataDistance = trainingWeeklySummaryDTOs[weeklySummaryIndex].startDate.distance(to: date)
                    let distance = trainingWeeklySummaryDTOs[weeklySummaryIndex].totalDistance
                    if abs(nthSalesDataDistance) < minDistance {
                        minDistance = abs(nthSalesDataDistance)
                        index = weeklySummaryIndex
                    }
                }
                if let index {
                    return trainingWeeklySummaryDTOs[index]
                }
            }
            return selectedElement
        }
    
}

//struct WeeklyTrainingSumaryTimeSeries_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyTrainingSumaryTimeSeries()
//    }
//}
