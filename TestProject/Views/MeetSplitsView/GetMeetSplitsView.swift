//
//  GetMeetSplitsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetMeetSplitsView: View {
    
    @State var season = ""
    @State var seasons: [String] = ["Select Season"]
    @State var runners: [Runner] = []
    @State var runnerName = ""
    @State var meetSplits: [MeetSplit] = []
    
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
            Background().edgesIgnoringSafeArea(.all)
                .onAppear{
                    self.fetchSeasons()
                }
            
            VStack() {
                Text("UAXC Meet Splits")
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
                    Button("Get MeetSplits") {
                       
                        let dataService = DataService()
                        let name = runnerName.components(separatedBy: ":")[0]
                        dataService.fetchMeetSplitsForRunner(runnerName: name, year: season) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let meetSplitsResponse):
                                    meetSplits = meetSplitsResponse.splits
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                            
                        }
                        
                    }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.title2)
                }
                
                if (!meetSplits.isEmpty) {
                    MeetSplitsList(meetSplits: meetSplits)
                } else {
                    Spacer().frame(minHeight: 20, maxHeight: 500)
                }
                
            }
        }
    }
}

