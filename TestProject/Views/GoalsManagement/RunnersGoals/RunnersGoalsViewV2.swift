//
//  RunnersGoalsViewV2.swift
//  UAXC
//
//  Created by David  Terkula on 12/28/22.
//

import SwiftUI

struct RunnersGoalsViewV2: View {
    
    @State var season = ""
    @State var seasons: [String] = ["Select Season"]
    @State var runners: [Runner] = []
    @State var runner: Runner?
    @State var runnerName = ""
    @State var goalsResponse: RunnersGoals?
    @State var goalsViewModel = GoalsViewModel()
    @EnvironmentObject var authentication: Authentication
    
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
        
        if (authentication.user?.role == "runner" && authentication.runner != nil) {
            runners = [ authentication.runner! ]
            runner = authentication.runner!
            runnerName = authentication.runner!.name
        } else {
            if (!season.isEmpty) {
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
            }

        }

    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear{
                        self.fetchSeasons()
                        self.fetchRunners()
                        if (goalsResponse != nil) {
                            goalsViewModel.goals.removeAll()
                            goalsViewModel.goals.append(contentsOf: goalsResponse!.goals)
                        }
                    }
            
                VStack() {
                    if (authentication.user != nil && authentication.user!.role == "runner" && authentication.runner != nil) {
                        Text(authentication.runner!.name + "'s Goals")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            SeasonPickerView(seasons: $seasons, season: $season)
                        }.padding(.bottom, 15)
                        
                    } else { // coaches view
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
                                    .onChange(of: runnerName) { newValue in
                                        runner = runners.first{$0.name == runnerName.components(separatedBy: ":")[0]}!
                                    }
                                
                            }.padding(.bottom, 15)
                        }
                    }
                    
                    
                    
                    if (runner != nil && !season.isEmpty) {
                        Button("Get Goals") {
                           
                            let dataService = DataService()
                            dataService.fetchGoalsForRunnersV2(runnerId: runner!.runnerId, season: season) { (result) in
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
                    
                    if (goalsResponse != nil && runner != nil) {
                        ScrollView {
                            HStack {
                                Spacer()
                                GoalsListView(runner: $runner, season: $season, goalsViewModel: goalsViewModel)
                                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height, alignment: .center)
                                    .environment(\.colorScheme, .light)
                                
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

//struct RunnersGoalsViewV2_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnersGoalsViewV2()
//    }
//}
