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
    
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Text("Runner Profile")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Text("Runner Name: ")
                            .foregroundColor(.white)
                            .font(.title2)
                        
                        TextField("Maria Rumely", text: $runnerName)
                            .keyboardType(.default)
                            .foregroundColor(.white)
                            .placeholder(when: $runnerName.wrappedValue.isEmpty) {
                                    Text("Maria Rumely").foregroundColor(.white)
                            }
                    }
                    .padding(.top, 20)
                    
                    Button("Get Profile") {
                        let dataService = DataService()
                        dataService.fetchRunnerProfile(runnerName: runnerName) { (result) in
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
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }.foregroundColor(.white)
                        .font(.title2)
                        .padding(.bottom, 50.0)
                    
                    VStack {
                        
                        ZStack {
                            if (runnerProfileResponse?.runnerProfile.runner != nil) {
                                Color.gray.ignoresSafeArea()
                            }
                            VStack(alignment: .leading) {
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
                                    
                                    if (runnerProfileResponse?.runnerProfile.raceConsistencyRank != nil) {
                                        RaceConsistencyRankView(raceConsistencyRank: (runnerProfileResponse?.runnerProfile.raceConsistencyRank)!)
                                    }
                                    
                                }
                            }
                           
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
