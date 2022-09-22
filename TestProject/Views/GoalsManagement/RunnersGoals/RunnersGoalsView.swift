//
//  GoalsView.swift
//  UAXC
//
//  Created by David  Terkula on 9/15/22.
//

import SwiftUI

struct RunnersGoalsView: View {
    @State var season = ""
    @State var seasons: [String] = ["Select Season"]
    @State var runners: [Runner] = []
    @State var runnerName = ""
    @State var goalsResponse: RunnersGoals?
    @State var goalsViewModel = GoalsViewModel()
    
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
    
    func fetchRunners() {
        
        dataService.fetchPossibleRunners(season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let runnersResponse):
                    runners = runnersResponse
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear{
                        self.fetchSeasons()
                    }
            
                    VStack() {
                        Text("Runner's Goals")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            SeasonPickerView(seasons: $seasons, season: $season)
                        }
                        .onChange(of: season) { newSeason in
                            self.fetchRunners()
                        }
                        .padding(.bottom, 15)
                        
                        if (!season.isEmpty) {
                            HStack {
                                RunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                                
                            }.padding(.bottom, 15)
                        }
                        
                        if (!runnerName.isEmpty && !season.isEmpty) {
                            Button("Get Goals") {
                               
                                let dataService = DataService()
                                let name = runnerName.components(separatedBy: ":")[0]
                                dataService.fetchGoalsForRunners(runner: name, season: season) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let goals):
                                            goalsResponse = goals
                                            if (goalsResponse != nil) {
                                                goalsViewModel.goals.removeAll()
                                                goalsViewModel.goals.append(contentsOf: goalsResponse!.goals)
                                            }
                                            case .failure(let error):
                                                print(error)
                                        }
                                    }
                                    
                                }
                                
                            }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                .font(.title2)
                        }
                        
                        if (goalsResponse != nil) {
                            ScrollView {
                                HStack {
                                    Spacer()
                                    GoalsListView(runnerName: $runnerName, season: $season, goalsViewModel: goalsViewModel)
                                        .frame(width: geometry.size.width * 0.95, height: geometry.size.height, alignment: .center)
                                        .background(.thinMaterial)
                                    Spacer()
                                }
                               
                            }
                            
                        } else {
                            Spacer().frame(minHeight: 20, maxHeight: 500)
                        }

                    } // end top vstack
                

            } // end zstack
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        } // end top geometry
    }
}

//struct GoalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalsView()
//    }
//}
