//
//  ProfileRanksView.swift
//  UAXC
//
//  Created by David  Terkula on 12/27/22.
//

import SwiftUI


struct ProfilePRRankView: View {
    
    var prRank: RankedPRDTO?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Rank:")
                    .bold()
                
                if (prRank != nil ) {
                    Text(String(prRank!.rank))
                } else {
                    Text("N/A")
                }
                
                NavigationLink(destination: PRLeaderboardView()) {
                    EmptyView()
                }
                .frame(height: 20)
                
            }
            
            if (prRank != nil) {
                PRRunnerProfileView(pr: prRank!.result)
            }
        }
    }
}


struct ProfileSBRankView: View {
    
    @Binding 
    var season: String
    @Binding
    var seasons: [String]
    var sbRank: RankedSBDTO?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Rank:")
                    .bold()
                
                if (sbRank != nil) {
                    Text(String(sbRank!.rank))
                } else {
                    Text("N/A")
                }
                
                NavigationLink(destination: SBLeaderboardView(seasons: seasons, season: season)) {
                    EmptyView()
                }.frame(height: 20)
                
            }
            
            if (sbRank != nil) {
                SeasonBestProfileView(sb: sbRank!)
                
            }
        }
    }
}


struct ProfileTimeTrialRankView: View {
    
    @Binding
    var season: String
    @Binding
    var seasons: [String]
    var timeTrialRank: TimeTrialProgression?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Rank:")
                    .bold()
                
                if (timeTrialRank != nil) {
                    Text(String(timeTrialRank!.rank))
                } else {
                    Text("N/A")
                }
            }
            
            if (timeTrialRank != nil && timeTrialRank!.seasonBest != "00:00") {
                HStack {
                    Text("5k Adjusted Time Trial:")
                        .bold()
                    Text(timeTrialRank!.adjustedTimeTrial)
                }
                
                HStack {
                    Text("Current SB:")
                        .bold()
                    Text(timeTrialRank!.seasonBest)
                }
                
                HStack {
                    Text("Improvement:")
                        .bold()
                    Text(timeTrialRank!.improvement)
                }
            }
        }
    }
}

struct ProfileDistanceRankView: View {
    
    @Binding
    var season: String
    @Binding
    var seasons: [String]
    var runnerDistance: RankedRunnerDistanceRunDTO?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Rank:")
                    .bold()
                
                if (runnerDistance != nil) {
                    Text(String(runnerDistance!.rank))
                } else {
                    Text("N/A")
                }
                
                Spacer()
                
                NavigationLink(destination: TrainingDistanceRunLeaderboardView(seasons: seasons, season: season)) {
                    EmptyView()
                }
                .frame(height: 20)
                
            }
            
            if (runnerDistance != nil) {
                HStack {
                    Text("Logged Miles:")
                        .bold()
                    Text(String(runnerDistance!.distance.rounded(toPlaces: 2)))
                }
                
            }

        }
    }
}


struct ProfileRaceSplitConsistencyView: View {
    
    @Binding
    var season: String
    @Binding
    var seasons: [String]
    var raceConsistency: RankedSplitConsistencyDTO?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Rank:")
                    .bold()
                
                if (raceConsistency != nil) {
                    Text(String(raceConsistency!.rank))
                } else {
                    Text("N/A")
                }
                
                NavigationLink(destination: RaceSplitConsistencyLeaderboardView(seasons: seasons, season: season)) {
                   EmptyView()
                }
                .frame(height: 20)
            }
            
            if (raceConsistency != nil) {
                HStack {
                    Text("Avg Race Split Spread:")
                        .bold()
                    Text(String(raceConsistency!.consistencyValue.rounded(toPlaces: 2)))
                }
                
            }

        }
    }
}

struct ProfileRanksView: View {
    
    @Binding
    var season: String
    @Binding
    var seasons: [String]
    var prRank: RankedPRDTO?
    var sbRank: RankedSBDTO?
    var raceConsistency: RankedSplitConsistencyDTO?
    var runnerDistance: RankedRunnerDistanceRunDTO?
    var timeTrialRank: TimeTrialProgression?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Group { // pr group
                HStack {
                    Text("PR Rank:")
                        .bold()
                    
                    if (prRank != nil ) {
                        Text(String(prRank!.rank))
                    } else {
                        Text("N/A")
                    }
                    
                    NavigationLink(destination: PRLeaderboardView()) {
                        EmptyView()
                    }
                    .frame(height: 20)
                    
                }
                
                if (prRank != nil) {
                    PRRunnerProfileView(pr: prRank!.result)
                }
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                    .padding(.bottom, 8)
            }
            
            
            Group { // sb group
                HStack {
                    Text("SB Rank:")
                        .bold()
                    
                    if (sbRank != nil) {
                        Text(String(sbRank!.rank))
                    } else {
                        Text("N/A")
                    }
                    
                    NavigationLink(destination: SBLeaderboardView(seasons: seasons, season: season)) {
                        EmptyView()
                    }.frame(height: 20)
                    
                }
                
                if (sbRank != nil) {
                    SeasonBestProfileView(sb: sbRank!)
                    
                }
                
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                    .padding(.bottom, 8)
                
            }
            
            Group { // time trial progression group
                
                HStack {
                    Text("Time Trial Improvment Rank:")
                        .bold()
                    
                    if (timeTrialRank != nil) {
                        Text(String(timeTrialRank!.rank))
                    } else {
                        Text("N/A")
                    }
                }
                
                if (timeTrialRank != nil && timeTrialRank!.seasonBest != "00:00") {
                    HStack {
                        Text("5k Adjusted Time Trial:")
                            .bold()
                        Text(timeTrialRank!.adjustedTimeTrial)
                    }
                    
                    HStack {
                        Text("Current SB:")
                            .bold()
                        Text(timeTrialRank!.seasonBest)
                    }
                    
                    HStack {
                        Text("Improvement:")
                            .bold()
                        Text(timeTrialRank!.improvement)
                    }
                }
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                    .padding(.bottom, 8)
            } // end time trial group
            
            Group { // distance run rank
                
                HStack {
                    Text("Training Miles Run:")
                        .bold()
                    
                    if (runnerDistance != nil) {
                        Text(String(runnerDistance!.rank))
                    } else {
                        Text("N/A")
                    }
                    
                    NavigationLink(destination: TrainingDistanceRunLeaderboardView(seasons: seasons, season: season)) {
                        EmptyView()
                    }
                    .frame(height: 20)
                    
                }
                
                if (runnerDistance != nil) {
                    Text("Logged Miles:")
                        .bold()
                    Text(String(runnerDistance!.distance.rounded(toPlaces: 2)))
                }
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                    .padding(.bottom, 8)
                
            } // end distance run rank
            
            Group {
                HStack {
                    Text("Race Mile Split Consistency:")
                        .bold()
                    
                    if (raceConsistency != nil) {
                        Text(String(raceConsistency!.rank))
                    } else {
                        Text("N/A")
                    }
                    
                    NavigationLink(destination: RaceSplitConsistencyLeaderboardView(seasons: seasons, season: season)) {
                       EmptyView()
                    }
                    .frame(height: 20)
                }
                
                if (raceConsistency != nil) {
                    Text("Avg Race Split Spread:")
                        .bold()
                    Text(String(raceConsistency!.consistencyValue.rounded(toPlaces: 2)))
                }
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                    .padding(.bottom, 8)
            }
            
        } // end vstack
    }
}

//struct ProfileRanksView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileRanksView()
//    }
//}
