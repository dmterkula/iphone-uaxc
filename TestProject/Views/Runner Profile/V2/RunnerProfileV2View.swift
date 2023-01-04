//
//  RunnerProfileV2View.swift
//  UAXC
//
//  Created by David  Terkula on 12/27/22.
//

import SwiftUI

struct RunnerProfileV2View: View {
    
    @EnvironmentObject var authentication: Authentication
    
    @State
    var runnerName: String = ""
    
    @State
    var runner: Runner?
    
    @State
    var runnerProfileResponse: RunnerProfileDTOV2?
    
    @State
    var trainingRunSummary: [TrainingSummaryDTO] = []
    
    @State
    var meetResultsDisclosureGroupExpanded: Bool = false
    
    @State
    var trainingRunDisclosureGroupExpanded: Bool = false


    @State
    var workoutsDisclosureGroupExpanded: Bool = false
    
    @State var showProgressView = false
    
    let dataService = DataService()
    
    @State var season: String = ""
    @State var seasons: [String] = []
    @State var runners: [Runner] = []
    
    func fetchProfile() {
        showProgressView = true
        dataService.fetchRunnerProfileV2(runnerId: runners.first{$0.name == runnerName.components(separatedBy: ":")[0]}!.runnerId, season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    runnerProfileResponse = response
                    showProgressView = false
                    runner = response.runner
                    trainingRunSummary = response.trainingRunSummary
                case .failure(let error):
                    print(error)
                    runnerProfileResponse = nil
                }
            }
        }
    }
    
    func fetchProfileAsRunner() {
        
        if (runnerProfileResponse == nil) {
            showProgressView = true
        }
       
        dataService.fetchRunnerProfileV2(runnerId: authentication.runner!.runnerId, season: GlobalFunctions.getRelevantYear()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    runnerProfileResponse = response
                    showProgressView = false
                    runner = response.runner
                    trainingRunSummary = response.trainingRunSummary
                case .failure(let error):
                    print(error)
                    runnerProfileResponse = nil
                }
            }
        }
    }
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    season = seasons[0]
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
    
    func getRunnersTitle() -> String {
        if(authentication.runner!.name.last! == "s") {
            return authentication.runner!.name + "' Profile"
        } else {
            return authentication.runner!.name + "'s Profile"
        }
    }
    
    
    
    @ViewBuilder
    func buildMetAchievementsView() -> some View {
        
        if (runnerProfileResponse != nil) {
        
            let metAchievments = getMetAchievementsToDisplay(runnerAchievements: runnerProfileResponse!.achievements)
            
            if (!metAchievments.isEmpty) {
                 let achievementPairs = metAchievments.chunked(into: 2)
                
                ForEach(Array(achievementPairs.enumerated()), id: \.offset) { index, element in
                    if (element.count == 1) {
                        AchievementRow(achievement1: element[0])
                    } else {
                        AchievementRow(achievement1: element[0], achievement2: element[1])
                    }
                }
            }

        } else {
            Text("N/A")
        }
        
    }
    
    @ViewBuilder
    func buildUnmetAchievementsView() -> some View {
        
        if (runnerProfileResponse != nil) {
        
            let unMetAchievments = getUnmetAchievementsToDisplay(runnerAchievements: runnerProfileResponse!.achievements)
            
            if (!unMetAchievments.isEmpty) {
                 let achievementPairs = unMetAchievments.chunked(into: 2)
                
                ForEach(Array(achievementPairs.enumerated()), id: \.offset) { index, element in
                    if (element.count == 1) {
                        UnMetAchievementRow(achievement1: element[0])
                    } else {
                        UnMetAchievementRow(achievement1: element[0], achievement2: element[1])
                    }
                }
            }

        } else {
            Text("N/A")
        }
        
    }
    
    func getMetAchievementsToDisplay(runnerAchievements: RunnerAchievements) -> [Achievement] {

        var achievements: [Achievement?] = []
        
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.prAchievements))
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.loggedRunAchievement))
        
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.totalTrainingDistanceAchievements))
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.consistentRaceAchievements))
        
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.wonRaceAchievements))
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.passesLastMileAchievements))
        
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.skullStreakAchievement))
        achievements.append(getMetAchievement(achievementsInCategory: runnerAchievements.totalSkullsEarnedAchievement))
        
        return achievements.filter { $0 != nil }.map { $0! }
        
    }
    
    func getUnmetAchievementsToDisplay(runnerAchievements: RunnerAchievements) -> [Achievement] {

        var achievements: [Achievement?] = []
        
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.prAchievements))
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.loggedRunAchievement))
        
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.totalTrainingDistanceAchievements))
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.consistentRaceAchievements))
        
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.wonRaceAchievements))
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.passesLastMileAchievements))
        
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.skullStreakAchievement))
        achievements.append(getUnMetAchievement(achievementsInCategory: runnerAchievements.totalSkullsEarnedAchievement))
        
        return achievements.filter { $0 != nil }.map { $0! }
        
    }
    
    func getMetAchievement(achievementsInCategory: [Achievement]) -> Achievement? {
        
        // return the highest met achievement in the provided category, or null if none met.
        
        var achievements = achievementsInCategory.sorted(by: { $0.threshold >= $1.threshold })
        return achievements.first(where: {$0.met })
    }
    
    func getUnMetAchievement(achievementsInCategory: [Achievement]) -> Achievement? {
        
        // return the next achievement that can be meet in the provided category, or null if all have been achieved in this category.
        
        var achievements = achievementsInCategory.sorted(by: { $0.threshold <= $1.threshold })
        return achievements.first(where: {!$0.met })
    }
    
  
    
    var body: some View {
        
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear {
                
                if (authentication.user!.role == "runner") {
                    if (runnerProfileResponse == nil) {
                        fetchProfileAsRunner()
                    }
                }
                self.fetchSeasons()
            }.onChange(of: season) { newSeason in
                if (authentication.user!.role == "runner") {
                    fetchProfileAsRunner()
                }
                self.fetchRunners()
            }
            
            VStack {
                
                SeasonPickerView(seasons: $seasons, season: $season)
                
                
                if (authentication.user?.role == "coach") {
                    RunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                    
                    if (!runnerName.isEmpty) {
                        Button("Get Profile") {
                            fetchProfile()
                        }
                        .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.title2)
                        .padding(.bottom,40.0)
                    }
                } else if (authentication.user?.role == "runner") {
                    Text(getRunnersTitle())
                        .font(.title)
                        .foregroundColor(.white)
                        
                }
                
                
                if (showProgressView == true) {
                   ProgressView()
                       .progressViewStyle(CircularProgressViewStyle(tint: .black))
                       .scaleEffect(5)
                       .padding(.top, 40)
                       .padding(.bottom, 40)
                                           
                }
                
                Form {
                    
                    Section(header: Text("Training Summary")) {
                        
                        if (runnerProfileResponse != nil && !(runnerProfileResponse!.trainingRunSummary.isEmpty)) {
                            
                            TrainingSummaryGraphView(trainingSummaryDTOs: $trainingRunSummary, runner: $runner, season: $season)
                                .frame(height: 500)
                        } else {
                            Text("N/A")
                        }
                        
                    }
                    
                    Section(header: Text("Training Runs")) {
                        DisclosureGroup("View Logged Training Runs", isExpanded: $trainingRunDisclosureGroupExpanded) {
                            if (runnerProfileResponse != nil && !(runnerProfileResponse?.trainingRuns.isEmpty)!) {
                                TrainingRunResultsProfileView(results: runnerProfileResponse!.trainingRuns)
                            } else {
                                Text("N/A")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Completed Workouts")) {
                        
                        DisclosureGroup("Show Workouts", isExpanded: $workoutsDisclosureGroupExpanded) {
                            
                            if (runnerProfileResponse != nil && !runnerProfileResponse!.workoutResults.isEmpty) {
                                WorkoutsProfileView(workoutResults: runnerProfileResponse!.workoutResults)
                            } else {
                                Text("N/A")
                            }
                            
                        }
                        
                    }
                   
                    Section(header: Text("Meet Results")) {
                        DisclosureGroup("Show Results", isExpanded: $meetResultsDisclosureGroupExpanded) {

                            if (runnerProfileResponse != nil && !runnerProfileResponse!.meetResults.isEmpty) {
                                VStack(alignment: .leading, spacing: 3) {
                                    GetMeetResultsForRunnerView(results: runnerProfileResponse!.meetResults)
                                }
                            } else {
                                Text("N/A")
                            }
                        }
                    }
                    
                    Section(header: HStack {
                        Text("Goals")
                        Spacer()
                        if (runner != nil && runnerProfileResponse != nil) {
                            NavigationLink(destination: RunnersGoalsViewV2(season: season, runner: runner, goalsResponse: RunnersGoals(runner: runner!, goals: runnerProfileResponse!.goals)).environment(\.colorScheme, .light)) {
                                Image(systemName: "chevron.right")
                            }
                        }
                    })
                    {
                        
                        if (runnerProfileResponse != nil && !runnerProfileResponse!.goals.isEmpty) {
                            GoalViewRunnerProfile(goals: runnerProfileResponse!.goals)
                        } else {
                            Text("N/A")
                        }
                    }
                    
                    Group {
                        Section(header: Text("PR")) {
                            if (runnerProfileResponse != nil && runnerProfileResponse!.rankedPR != nil) {
                                ProfilePRRankView(prRank: runnerProfileResponse!.rankedPR)
                            } else {
                                Text("N/A")
                            }
                           
                        }
                        
                        Section(header: Text("SB")) {
                            if (runnerProfileResponse != nil && runnerProfileResponse!.rankedSB != nil) {
                                ProfileSBRankView(season: $season, seasons: $seasons, sbRank: runnerProfileResponse!.rankedSB)
                            } else {
                                Text("N/A")
                            }
                           
                        }
                        
                        Section(header: Text("Time Trial")) {
                            if (runnerProfileResponse != nil && runnerProfileResponse!.timeTrial != nil) {
                                ProfileTimeTrialRankView(season: $season, seasons: $seasons, timeTrialRank: runnerProfileResponse!.timeTrial)
                            } else {
                                Text("N/A")
                            }
                           
                        }
                        
                        Section(header: Text("Training Distance")) {
                            if (runnerProfileResponse != nil && runnerProfileResponse!.distanceRun != nil) {
                                ProfileDistanceRankView(season: $season, seasons: $seasons, runnerDistance: runnerProfileResponse!.distanceRun)
                            } else {
                                Text("N/A")
                            }
                           
                        }
                        
                        Section(header: Text("Race Split Spread Consistency")) {
                            if (runnerProfileResponse != nil && runnerProfileResponse!.consistencyRank != nil) {
                                ProfileRaceSplitConsistencyView(season: $season, seasons: $seasons, raceConsistency: runnerProfileResponse!.consistencyRank)
                            } else {
                                Text("N/A")
                            }
                           
                        }
                    } // end group
                    
                    Group {
                        Section(header: Text("Met Achievements")) {
                            
                            if (runnerProfileResponse != nil) {
                               
                                VStack {
                                    buildMetAchievementsView()
                                }
                            
                               
                            } else {
                                Text("N/A")
                            }
                            
                           
                            
                        }.frame(maxHeight: .infinity)
                        
                        Section(header: Text("Unmet Achievements")) {
                           
                            if (runnerProfileResponse != nil) {
                                VStack {
                                    buildUnmetAchievementsView()
                                }
                               
                            } else {
                                Text("N/A")
                            }
                            
                        }
                    }
                
                } // end form
                .refreshable{
                    if(authentication.user?.role == "runner") {
                        fetchProfileAsRunner()
                    } else {
                        fetchProfile()
                    }
                }
                
            }
        
        }
    }
}

//struct RunnerProfileV2View_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerProfileV2View()
//    }
//}
