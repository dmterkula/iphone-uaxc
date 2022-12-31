//
//  TrainingSummaryGraphView.swift
//  UAXC
//
//  Created by David  Terkula on 12/28/22.
//

import SwiftUI

struct TrainingSummaryGraphView: View {
    
    @Binding var trainingSummaryDTOs: [TrainingSummaryDTO]
    @Binding var runner: Runner?
    @Binding var season: String
    
    @State var byWeek = true
    @State var byDay = false
    @State var byMonth = false
    
    @State private var selectedElement: TrainingSummaryDTO?
    
    let dataService = DataService()
    
    
    func makeChartDescriptor() -> AXChartDescriptor {
        
        var chartFrequency = "weekly"
        if (byDay) {
            chartFrequency = "daily"
        } else if (byMonth) {
            chartFrequency = "monthly"
        }
        
        return AccessibilityHelpers.chartDescriptor(trainingSummaryDTOs: trainingSummaryDTOs, chartFrequency: chartFrequency)
    }
    
    func getChartFrequency()-> String {
        if (byWeek) {
            return "weekly"
        } else if (byMonth) {
            return "monthly"
        } else if (byDay) {
            return "daily"
        } else {
           return "weekly"
        }
    }
    
    func refreshGraph() {
        
        dataService.getRunnersTrainingSummary(season: season, runnerId: runner!.runnerId, timeFrame: getChartFrequency()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weeklySummary):
                    trainingSummaryDTOs = weeklySummary
                    if (!trainingSummaryDTOs.isEmpty) {
                        selectedElement = trainingSummaryDTOs.first!
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
        
                
            HStack {
                
            CheckBoxView(checked: $byDay)
                .onChange(of: byDay) { newValue in
                    if (newValue == true) {
                       byWeek = false
                       byMonth = false
                       refreshGraph()
                    }
                }
                
                Text("Daily")
                
                
            CheckBoxView(checked: $byWeek)
                .onChange(of: byWeek) { newValue in
                    if (newValue == true) {
                       byDay = false
                       byMonth = false
                       refreshGraph()
                    }
                }
                
                Text("Weekly")
               
                
            CheckBoxView(checked: $byMonth)
                .onChange(of: byMonth) { newValue in
                    if (newValue == true) {
                       byDay = false
                       byWeek = false
                       refreshGraph()
                    }
                }
                
            Text("Monthly")
               
            }

            if (trainingSummaryDTOs.isEmpty) {
                Button {
                    refreshGraph()
                } label: {
                    if (byWeek) {
                        Text("Get Weekly Training Summary")
                            .foregroundColor(GlobalFunctions.gold())
                    } else if (byMonth) {
                        Text("Get Monthly Training Summary")
                            .foregroundColor(GlobalFunctions.gold())
                    } else {
                        Text("Get Daily Training Summary")
                            .foregroundColor(GlobalFunctions.gold())
                    }
                   
                }
            }

            
            if (!trainingSummaryDTOs.isEmpty) {
                
                TrainingSumaryTimeSeries(trainingWeeklySummaryDTOs: $trainingSummaryDTOs, selectedElement: trainingSummaryDTOs.first!, chartFrequency: getChartFrequency())
            }
        }
    }
}

//struct TrainingSummaryGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingSummaryGraphView()
//    }
//}
