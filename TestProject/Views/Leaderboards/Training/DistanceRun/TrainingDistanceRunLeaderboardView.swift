//
//  TrainingDistanceRunLeaderboardView.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import SwiftUI

struct TrainingDistanceRunLeaderboardView: View {
    @State var leaderboard: [RankedRunnerDistanceRunDTO] = []
    @State var seasons: [String] = []
    @State var season: String = ""
    @State var showProgressView = false
    @EnvironmentObject var authentication: Authentication
    
    @State var forSeason: Bool = false
    @State var forCareer: Bool = false
    
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
    
    func fetchLeaderboard(season: String?) {
        
        var pageValue: Int? = nil
        
        if (authentication.user?.role == "runner") {
            pageValue = 25
        }
        
        dataService.getTrainingDistanceLeaderboard(season: season, page: pageValue) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let rankedRunnerDistanceRunDTO):
                    leaderboard = rankedRunnerDistanceRunDTO
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
                    Text("Distance Run Leaderboard")
                        .foregroundColor(.white)
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 20)
                    
                    HStack {
                      
                        CheckBoxView(checked: $forSeason)
                            .onChange(of: forSeason) { newValue in
                                if (newValue) {
                                    forCareer = false
                                }
                            }
                        Text("For Season")
                        
                        CheckBoxView(checked: $forCareer).onChange(of: forCareer) { newValue in
                            if (newValue) {
                                forSeason = false
                            }
                        }
                        Text("For Career")
                    }
                    .padding(.bottom, 10)
                    
                    if (forSeason) {
                        SeasonPickerView(seasons: $seasons, season: $season, label: "Select Season: ")
                            .padding(.bottom, 30)
                    }
                    
                    if (forSeason || forCareer) {
                        Button () {
                            showProgressView = true
                            if (forSeason) {
                                fetchLeaderboard(season: season)
                            } else {
                                fetchLeaderboard(season: nil)
                            }
                        } label : {
                            Text("Get Leaderboard")
                                .font(.system(size: 20))
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
                        Text("* Values shown is total miles run")
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    }
                    
                    List {
                        ForEach(leaderboard) { rankedRunnerDistanceRunDTO in
                          TrainingDistanceLeaderboardRow(rankedRunnerDistanceRunDTO: rankedRunnerDistanceRunDTO)
                        }
                    }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.60)
                    
                }
                
                
            }
        }
    }
}

//struct TrainingDistanceRunLeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingDistanceRunLeaderboardView()
//    }
//}
