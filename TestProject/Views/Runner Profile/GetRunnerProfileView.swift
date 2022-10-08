//
//  GetRunnerProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import SwiftUI

struct GetRunnerProfileView: View {
    
    @State
    var runnerName: String = ""
    
    @State
    var runnerProfileResponse: RunnerProfileResponse?
    
    @State
    var meetResultsDisclosureGroupExpanded: Bool = false
    
    @State
    var meetResultForRunnerResponse: MeetResultsForRunnerResponse?
    
    let dataService = DataService()
    
    @State var season: String = ""
    @State var runners: [Runner] = []
    
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    season = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()[0]
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func fetchRunners() {
        
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
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear {
                self.fetchSeasons()
            }
            .onChange(of: season) { newSeason in
                self.fetchRunners()
            }
            ScrollView {
                VStack {
                    Text("Runner Profile")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    
                    RunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                    
                    Button("Get Profile") {
                        let dataService = DataService()
                        dataService.fetchRunnerProfile(runnerName: runnerName.components(separatedBy: ":")[0]) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                   runnerProfileResponse = response
                                    case .failure(let error):
                                        print(error)
                                    runnerProfileResponse = nil
                                }
                            }
                        }
                        
                        dataService.fetchMeetResultsByRunnerName(runnerName: runnerName.components(separatedBy: ":")[0], startSeason: "", endSeason: "") { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                   meetResultForRunnerResponse = response
                                    case .failure(let error):
                                        print(error)
                                    meetResultForRunnerResponse = nil
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.title2)
                        .padding(.bottom,40.0)
                    
                    VStack {
                        
                        ZStack {
                            if (runnerProfileResponse?.runnerProfile.runner != nil) {
                                (Color(red: 107/255, green: 107/255, blue: 107/255))
                            }
                            VStack(alignment: .leading) {
                                Group {
                                    if (runnerProfileResponse != nil) {
                                        
                                        if (runnerProfileResponse?.runnerProfile.pr != nil) {
                                            let pr: RunnerProfilePR = (runnerProfileResponse?.runnerProfile.pr!)!
                                            PRRunnerProfileView(pr: pr.meetResult)
                                        }
                                        
                                        CustomDivider(color: .white, height: 5)
                                        
                                        if (runnerProfileResponse?.runnerProfile.seasonBest != nil) {
                                            let sb: RunnerProfileSeasonBestDTO = (runnerProfileResponse?.runnerProfile.seasonBest!)!
                                            SeasonBestProfileView(sb: sb)
                                            }
                                        
                                        CustomDivider(color: .white, height: 5)
                                        
                                        if (runnerProfileResponse?.runnerProfile.adjustedTimeTrial != nil) {
                                            AdjustedTimeTrialView(adjustedTimeTrial: (runnerProfileResponse?.runnerProfile.adjustedTimeTrial!)!)
                                        }
                                        
                                        CustomDivider(color: .white, height: 5)
                                        
                                        if (runnerProfileResponse?.runnerProfile.timeTrialProgressionRank != nil) {
                                            TimeTrialProgressionView(timeTrialProgressionRank: (runnerProfileResponse?.runnerProfile.timeTrialProgressionRank!)!)
                                        }
                                        
                                        CustomDivider(color: .white, height: 5)
                                    }
                                    Group {
                                        
                                        if (runnerProfileResponse?.runnerProfile.raceConsistencyRank != nil) {
                                            RaceConsistencyRankView(raceConsistencyRank: (runnerProfileResponse?.runnerProfile.raceConsistencyRank)!)
                                        }
                                        
                                        if (runnerProfileResponse != nil && meetResultForRunnerResponse != nil) {
                                            CustomDivider(color: .white, height: 5)
                                            
                                            DisclosureGroup("Show Meet Results", isExpanded: $meetResultsDisclosureGroupExpanded) {

                                                if (meetResultForRunnerResponse == nil) {
                                                    Text("No results").foregroundColor(.white)
                                                } else if (meetResultForRunnerResponse!.runnerMeetPerformanceDTOs.count == 0) {
                                                    Text("No runners found")
                                                } else if (meetResultForRunnerResponse!.runnerMeetPerformanceDTOs.count > 1) {
                                                    Text("Multiple runners found, specify full name")
                                                } else {
                                                    VStack(alignment: .leading, spacing: 3) {
                                                        GetMeetResultsForRunnerView(runnerMeetPerformanceDTO: meetResultForRunnerResponse!.runnerMeetPerformanceDTOs.first!)
                                                    }
                                                }

                                            }.background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .accentColor(.white)
                                        }
                                    }
                                }
                                
                            }.padding(.leading, 8)
                           
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                }
            }
        }
    }
}

//struct GetRunnerProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetRunnerProfileView()
//    }
//}
