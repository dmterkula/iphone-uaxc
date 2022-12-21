//
//  SBLeaderboardView.swift
//  UAXC
//
//  Created by David  Terkula on 12/13/22.
//

import SwiftUI

struct SBLeaderboardView: View {
    
    @State var leaderboard: [RankedSBDTO] = []
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
        
        dataService.getSBLeaderboard(season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sbLeaderboard):
                    leaderboard = sbLeaderboard
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
                    Text("SB Leaderboard")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.top, 20)
                    
//                    Text("Show the fastest times in the season you select")
//                        .foregroundColor(.white)
//                        .padding(.top, 10)
//                        .padding(.bottom, 10)
                    
                    SeasonPickerView(seasons: $seasons, season: $season, label: "Select Season: ")
                        .padding(.bottom, 30)
                    
                    if (!seasons.isEmpty) {
                        Button () {
                            showProgressView = true
                            fetchLeaderboard(season: season)
                        } label : {
                            Text("Get SB Leaderboard")
                        }.padding(.bottom, 30)
                            .foregroundColor(GlobalFunctions.gold())
                    }
                    
                    if (showProgressView == true) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(3)
                            .padding(.top, 50)
                            
                    }
                    
                    List {
                        ForEach(leaderboard) { rankedSBDTO in
                          SBLeaderboardRow(rankedSBDTO: rankedSBDTO)
                        }
                    }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.7)
                    
                }
                
                
            }
        }
    }
}

//struct SBLeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SBLeaderboardView()
//    }
//}
