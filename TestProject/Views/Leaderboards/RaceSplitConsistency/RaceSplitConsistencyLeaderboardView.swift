//
//  RaceSplitConsistencyLeaderboardView.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import SwiftUI

struct RaceSplitConsistencyLeaderboardView: View {
    @State var leaderboard: [RankedSplitConsistencyDTO] = []
    @State var seasons: [String] = []
    @State var season: String = ""
    @State var showProgressView = false
    
    let dataService = DataService()
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    season = seasons.first!
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func fetchLeaderboard(season: String) {
        
        dataService.getRankedSplitConsistencyLeaderboard(season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let rankedSplitConsistencyLeaderboard):
                    leaderboard = rankedSplitConsistencyLeaderboard
                    showProgressView = false
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear {
                        fetchSeasons()
                    }
                
                VStack {
                    Text("Race Split Consistency Leaderboard")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    SeasonPickerView(seasons: $seasons, season: $season, label: "Select Season: ")
                        .padding(.bottom, 30)
                    
                    if (!seasons.isEmpty) {
                        Button () {
                            showProgressView = true
                            fetchLeaderboard(season: season)
                        } label : {
                            Text("Get Leaderboard")
                        }.padding(.bottom, 30)
                            .foregroundColor(GlobalFunctions.gold())
                    }
                    
                    if (showProgressView == true) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(3)
                            .padding(.top, 50)
                            
                    }
                    
                    if (!leaderboard.isEmpty) {
                        Text("Values shown is avg spread between mile splits")
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                    
                    List {
                        ForEach(leaderboard) { rankedSplitConsistencyDTO in
                          RaceSplitConsistencyRow(rankedSplitConsistencyDTO: rankedSplitConsistencyDTO)
                        }
                    }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.60)
                    
                }
                
                
            }
        }
    }
}

struct RaceSplitConsistencyLeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        RaceSplitConsistencyLeaderboardView()
    }
}
