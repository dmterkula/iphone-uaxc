//
//  SkullsLeaderBoardView.swift
//  UAXC
//
//  Created by David  Terkula on 1/5/23.
//

import SwiftUI

struct SkullsLeaderBoardView: View {
   
    @State var leaderboard: [RankedAchievementDTO] = []
    @State var seasons: [String] = []
    @State var season: String = ""
    @State var showProgressView = false
    @EnvironmentObject var authentication: Authentication
    
    @State var forSeason: Bool = false
    @State var forCareer: Bool = false
    
    @State var forStreak: Bool = false
    @State var forTotal: Bool = false
    @State var forActive: Bool = false
    
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
    
    func fetchSkullTotalLeaderboard(season: String?) {
        
        var pageValue: Int? = nil
        
        if (authentication.user?.role == "runner") {
            pageValue = 25
        }
        
        dataService.getTotalSkullsLeaderboard(season: season, page: pageValue) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let skullTotalResponse):
                    leaderboard = skullTotalResponse
                    showProgressView = false
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    
    func fetchSkullStreakLeaderboard(season: String?) {
        
        var pageValue: Int? = nil
        
        if (authentication.user?.role == "runner") {
            pageValue = 25
        }
        
        dataService.getSkullsStreakLeaderboard(season: season, page: pageValue, active: forActive) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let skullTotalResponse):
                    leaderboard = skullTotalResponse
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
                    Text("Skulls Leaderboard")
                        .foregroundColor(.white)
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 20)
                    
                    HStack {
                        CheckBoxView(checked: $forTotal).onChange(of: forTotal) { newValue in
                            if (newValue) {
                                forStreak = false
                            }
                        }
                        Text("Total Skulls")
                        
                        CheckBoxView(checked: $forStreak)
                            .onChange(of: forStreak) { newValue in
                                if (newValue) {
                                    forTotal = false
                                }
                            }
                        Text("Skull Streak")
                        
                        if (forStreak) {
                            CheckBoxView(checked: $forActive)
                            Text("Active streak")
                        }
                        
                    }
                    .padding(.bottom, 10)
                    
                    if (forTotal || forStreak) {
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
                    }
                    

                    if (forSeason) {
                        SeasonPickerView(seasons: $seasons, season: $season, label: "Select Season: ")
                            .padding(.bottom, 30)
                    }
                    
                    if (forSeason || forCareer) {
                        Button () {
                            showProgressView = true
                            if (forTotal) {
                                if (forSeason) {
                                    fetchSkullTotalLeaderboard(season: season)
                                } else {
                                    fetchSkullTotalLeaderboard(season: nil)
                                }
                            } else {
                                if (forSeason) {
                                    fetchSkullStreakLeaderboard(season: season)
                                } else {
                                    fetchSkullStreakLeaderboard(season: nil)
                                }
                               
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
                    
                    List {
                        ForEach(leaderboard) { rankedAchievementDTO in
                            RankedAchievementRowView(rankedAchievementDTO: rankedAchievementDTO)
                        }
                    }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.60)
                    
                }
                
            }
        }
    }
}



//struct SkullsLeaderBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkullsLeaderBoardView()
//    }
//}
