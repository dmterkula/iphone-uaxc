//
//  ViewAllGoals.swift
//  UAXC
//
//  Created by David  Terkula on 9/20/22.
//

import SwiftUI

struct ViewAllGoals: View {
    
    @State var season = ""
    @State var seasons: [String] = ["Select Season"]
    
    @State var runnerGoals: [RunnersGoals] = []
    @State var metGoals: [RunnerToMetGoal] = []
    @State var unMetGoals: [RunnerToUnmetGoal] = []
    
    @State var allGoalsIsExpanded = false
    @State var metGoalsIsExpanded = false
    @State var unMetGoalsIsExpanded = false
    
    @State var allGoalsRequestCompleted = false
    @State var metGoalsRequestCompleted = false
    @State var unMetGoalsRequestCompleted = false
    
    @State var allGoalsNameFilter = ""
    @State var metGoalsNameFilter = ""
    @State var unMetGoalsNameFilter = ""
    
    @State var getDataButtonPushed = false
    
    @State var bars: [Bar] = []
    
    let dataService = DataService()
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func initializeBars() {
        
        let metGoalsCount = metGoals.flatMap{$0.metGoals}.count
        let metTimeGoalsBar = Bar(label: "Met Time Goals", value: Double(metGoalsCount), size: 1.0, scaleFactor: 1.0, color: .green)
        let unMetTimeGoalsBar = Bar(label: "Unmet Time Goals", value: Double(unMetGoals.count), size: 1.0, scaleFactor: 1.0, color: .red)
        
        bars = [metTimeGoalsBar, unMetTimeGoalsBar]
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear{
                        self.fetchSeasons()
                    }
                
                ScrollView {
                    VStack() {
                        Text("View All Goals")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            SeasonPickerView(seasons: $seasons, season: $season)
                        }
                        .padding(.bottom, 15)
                       
                        if (!season.isEmpty) {
                            Button("Get Goals") {
                               
                                allGoalsRequestCompleted = false
                                metGoalsRequestCompleted = false
                                unMetGoalsRequestCompleted = false
                                
                                getDataButtonPushed = true
                                dataService.fetchAllGoals(season: season) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            runnerGoals = response.runnerGoals
                                            allGoalsRequestCompleted = true
                                        case .failure(let error):
                                            print(error)
                                        }
                                    }
                                }
                                
                                dataService.fetchMetTimeGoals(season: season) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            metGoals = response.metGoals
                                            metGoalsRequestCompleted = true
                                            initializeBars()
                                        case .failure(let error):
                                            print(error)
                                        }
                                    }
                                    
                                }
                                
                                
                                dataService.fetchUnmetTimeGoals(season: season) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            unMetGoals = response.unMetGoals
                                            unMetGoalsRequestCompleted = true
                                            initializeBars()
                                        case .failure(let error):
                                            print(error)
                                        }
                                    }
                                    
                                }
                                
                            }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                .font(.title2)
                        }
                        
                        if ((!allGoalsRequestCompleted || !metGoalsRequestCompleted || !metGoalsRequestCompleted) && getDataButtonPushed) {
                            ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                 .scaleEffect(3)
                                 .padding(.top, 20)
                        } else {
                            
                            if (runnerGoals.isEmpty && unMetGoals.isEmpty && metGoals.isEmpty && getDataButtonPushed) {
                                Text("No goals data for the given year")
                                    .padding(.top, 20)
                            }
                            // display the data all at once
                            
                            if (!unMetGoals.isEmpty && !metGoals.isEmpty) {
                                
                                MetVsUnmetGoalsBarChart(bars: $bars, height: geometry.size.height * 0.25, width: geometry.size.width * 0.33, title: "Met Vs Unmet Goals")
                                    .padding(.bottom, 20)
                            }
                            
                            if (!runnerGoals.isEmpty) {
                                
                                ViewAllGoalsDisclosureGroup(allGoalsIsExpanded: $allGoalsIsExpanded, allGoalsNameFilter: $allGoalsNameFilter, geometry: geometry, runnerGoals: $runnerGoals)
                            }
                            
                            if (!metGoals.isEmpty) {
                                RunnerMetGoalsDisclosureGroup(metGoalsNameFilter: $metGoalsNameFilter, metGoals: $metGoals, metGoalsIsExpanded: $metGoalsIsExpanded, geometry: geometry)
                            }
                            if (!unMetGoals.isEmpty) {
                                RunnerUnmetGoalsDisclosureGroup(unMetGoalsNameFilter: $unMetGoalsNameFilter, unMetGoals: $unMetGoals, unMetGoalsIsExpanded: $unMetGoalsIsExpanded, geometry: geometry)
                            }
                            
                            else {
                                Spacer().frame(minHeight: 20, maxHeight: 500)
                            }
                        }
                        
                        

                    } // end top vstack
                
                    
                } // end scroll view


            } // end zstack
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        } // end top geometry
    }
}


//struct ViewAllGoals_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewAllGoals()
//    }
//}
