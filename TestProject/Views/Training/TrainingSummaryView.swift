//
//  WeeklyTrainingSummaryView.swift
//  UAXC
//
//  Created by David  Terkula on 12/23/22.
//

import SwiftUI
import Charts

struct TrainingSummaryView: View, AXChartDescriptorRepresentable {
    
    let dataService = DataService()
    
    @State
    var trainingSummaryDTOs: [TrainingSummaryDTO] = []
    
    @State
    var runnerName: String = ""
    
    @EnvironmentObject var authentication: Authentication
    
    @State var season: String = ""
    @State var seasons: [String] = []
    @State var runners: [Runner] = []
    @State var byWeek = true
    @State var byDay = false
    @State var byMonth = false
    
    @State private var showLollipop = true
    @State private var selectedElement: TrainingSummaryDTO?
    @State var isOverview: Bool = false
    
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
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    season = seasons[0]
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func fetchRunners() {
        
        if (authentication.user!.role == "coach") {
            dataService.fetchPossibleRunners(season: season, filterForIsActive: true) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let runnersResponse):
                        runners = runnersResponse
                        case .failure(let error):
                            print(error)
                    }
                }
            }
        } else {
            runners = [authentication.runner!]
        }

    }
    
    func refreshGraph() {
        
        dataService.getRunnersTrainingSummary(season: season, runnerId: runners.first{$0.name == runnerName.components(separatedBy: ":")[0]}!.runnerId, timeFrame: getChartFrequency()) { (result) in
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
    
    func getToggleText() -> String {
        if (byWeek) {
            return "By Week"
        } else {
            return "By Month"
        }
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear {
                self.fetchSeasons()
                if (authentication.user!.role == "runner") {
                    runners = [authentication.runner!]
                    runnerName = runners[0].name
                }
            }
            .onChange(of: season) { newSeason in
                if (authentication.user!.role == "coach") {
                    self.fetchRunners()
                }
            }
            
            VStack {
                
                Text("Training Summary")
                    .font(.title)
                    .padding(.bottom, 10)
                
                SeasonPickerView(seasons: $seasons, season: $season)
                
                if (authentication.user?.role == "coach") {
                    RunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                }
                
                
                if (!trainingSummaryDTOs.isEmpty) {
                    
                    HStack {
                        Text("Daily")
                        CheckBoxView(checked: $byDay)
                            .onChange(of: byDay) { newValue in
                                if (newValue == true) {
                                   byWeek = false
                                   byMonth = false
                                   refreshGraph()
                                }
                            }
                        
                        Text("Weekly")
                        CheckBoxView(checked: $byWeek)
                            .onChange(of: byWeek) { newValue in
                                if (newValue == true) {
                                   byDay = false
                                   byMonth = false
                                   refreshGraph()
                                }
                            }
                        
                        
                        Text("Monthly")
                        CheckBoxView(checked: $byMonth)
                            .onChange(of: byMonth) { newValue in
                                if (newValue == true) {
                                   byDay = false
                                   byWeek = false
                                   refreshGraph()
                                }
                            }
                    }
                    
                }
 
                
                if (!runnerName.isEmpty && !season.isEmpty) {
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

//struct WeeklyTrainingSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyTrainingSummaryView()
//    }
//}
