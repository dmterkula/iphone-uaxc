//
//  PRLeaderboardView.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import SwiftUI

struct PRLeaderboardView: View {
    
    @State var leaderboard: [RankedPRDTO] = []
    
    @EnvironmentObject var authentication: Authentication
    
    let dataService = DataService()
    
    func fetchLeaderboard() {
        
        var pageSize = 100
        
        if (authentication.user!.role == "coach") {
            pageSize = 1000
        }
        
        dataService.getPRLeaderboard(pageSize: pageSize) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let prLeaderboard):
                    leaderboard = prLeaderboard
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
                
                VStack {
                    Text("PR Leaderboard")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.top, 20)
                    
                    
                    if (leaderboard.isEmpty) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(3)
                            .padding(.top, 50)
                            .onAppear() {
                                fetchLeaderboard()
                            }
                    }
                    
                    List {
                        ForEach(leaderboard) { rankedPRDTO in
                            PRLeaderboardRow(rankedPRDTO: rankedPRDTO)
                        }
                    }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.75)
                    
                }
                
                
            }
        }

        
    }
}

struct PRLeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        PRLeaderboardView()
    }
}
