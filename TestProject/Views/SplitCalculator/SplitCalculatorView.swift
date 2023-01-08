//
//  SplitCalculatorView.swift
//  UAXC
//
//  Created by David  Terkula on 1/8/23.
//

import SwiftUI

struct SplitCalculatorView: View {
    
    @EnvironmentObject var authentication: Authentication
    @State var runner: Runner?
    @State var runners: [Runner] = []
    @State var runnerName: String = ""
    
    @State var season = ""
    @State var seasons: [String] = []
    
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var personalize: Bool = false
    @State var straightAverage: Bool = false
    @State var personalizedSplitDTO: PersonalizedSplitDTO? = nil
    
    @State var lastNRaces = 1
    
    let possibleLastNumberOfRaces = Array(0...50)
    
    let dataService = DataService()
    
    func getTimeString() -> String {
        
        var minuteString = ""
        var secondString = ""
        
        if (minutes < 10) {
            minuteString = "0" + String(minutes)
        } else {
            minuteString = String(minutes)
        }
        
        if (seconds < 10) {
            secondString = "0" + String(seconds)
        } else {
            secondString = String(seconds)
        }
        
        return minuteString + ":" + secondString
        
    }
    
    func calculateSplits() {
        
        var numRaces: Int? = nil
        
        if (lastNRaces != 0) {
            numRaces = lastNRaces
        }
        
        dataService.getPersonalizedSplitsDTO(runnerId: runner!.runnerId, lastNRaces: numRaces, inputTime: getTimeString()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                   personalizedSplitDTO = response
                case .failure(let error):
                    print(error)
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
                    var relevantYear = GlobalFunctions.getRelevantYear()
                    
                    if (!seasons.contains(relevantYear)) {
                        seasons.insert(relevantYear, at: 0)
                        season = relevantYear
                    }
                    
                    fetchRunners()
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
            Background().ignoresSafeArea().onAppear {
                if (authentication.user?.role == "runner") {
                    runner = authentication.runner
                }
                fetchSeasons()
            }
            
            VStack {
                
                Text("5k Split Calculator")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 20)
                
                Form {
                    
                    
                    if (authentication.user?.role != "runner") {
                        Section(header: Text("Pick a runner")) {
                            RunnerPickerViewLight(runners: $runners, runnerLabel: $runnerName)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                                .onChange(of: runnerName) { newValue in
                                    runner = runners.first { $0.name == newValue.components(separatedBy: ":")[0]}!
                                }
                        }
                    }
                    
                    if (runner != nil) {
                        Section(header: Text("Pick your target 5k time")) {
                            RaceTimePicker(minutesValue: $minutes, secondsValue: $seconds)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                        }
                        
                        Section(header: Text("Based On The Last Number Of Races")) {
                            
                            Picker("Select Last Number of Races:", selection: $lastNRaces) {
                                ForEach(possibleLastNumberOfRaces, id: \.self) { item in
                                    Text(String(item))
                                }
                            }
                        }

                    }
     
                    if (minutes != 0 && runner != nil) {
                        Section() {
                            Button() {
                                calculateSplits()
                            } label: {
                                Text("Calculate")
                            }
                        }
                    }
                    
                    if (personalizedSplitDTO != nil) {
                            
                        Section(header: Text("Evenly Paced Splits For " + getTimeString())) {
                            HStack {
                                Text("Mile Splits:").bold()
                                Text(personalizedSplitDTO!.averageTimeForInput)
                            }
                        }
                        
                        if (personalizedSplitDTO!.mile1Target != "0:NaN") {
                            Section(header: Text("Splits Based On Your Pacing Tendencis")) {
                                HStack {
                                    Text("Mile 1:")
                                        .bold()
                                       
                                    Text(personalizedSplitDTO!.mile1Target)
                                       
                                }
                                
                                HStack {
                                    Text("Mile 2:")
                                        .bold()
                                    Text(personalizedSplitDTO!.mile2Target)
                                      
                                }
                                
                                HStack {
                                    Text("Mile 3:")
                                        .bold()
                                    Text(personalizedSplitDTO!.mile3Target)

                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}

//struct SplitCalculatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplitCalculatorView()
//    }
//}
