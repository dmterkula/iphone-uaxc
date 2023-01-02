//
//  AddMeetResultsView.swift
//  UAXC
//
//  Created by David  Terkula on 12/31/22.
//

import SwiftUI

struct AddMeetResultsView: View {
    
    @EnvironmentObject var authentication: Authentication
    
    @State
    var runnerName: String = ""
    
    @State var season: String = ""
    @State var seasons: [String] = []
    @State var runners: [Runner] = []
    @State var runner: Runner?
    
    @State var meetName: String = ""
    @State var meets: [MeetDTO] = []
    @State var showSheet = false
    
    @State var viewModel = AddRunnerMeetResultFormViewModel(runner: nil, meet: "", season: "")
    
    @State var totalMeetPerformancesDTOs: [RunnerTotalMeetPerformanceDTO] = []
    
    let dataService = DataService()
    
    func refreshMeetResults() {
        runnerName = ""
        viewModel = AddRunnerMeetResultFormViewModel(runner: nil, meet: meetName, season: season)
        dataService.getTotalMeetResults(season: season, meetName: meetName) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    totalMeetPerformancesDTOs = response
                    print(response)
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
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func fetchMeetNames() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    
                    meets = meetInfoResponse.meets
                    
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
    
    func getTitle() -> String {
        if (authentication.user?.role == "runner") {
            return "View Meet Result"
        } else {
            return "View or Edit Meet Results"
        }
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
                .onAppear {
                    fetchMeetNames()
                }
            
            VStack {
                
                Text("View and Edit Meet Results")
                    .foregroundColor(.white)
                    .font(.title)
                
               SeasonAndMeetPickerView(season: $season, seasons: $seasons, meets: $meets, meetName: $meetName)
                    .onChange(of: season) { newValue in
                        fetchRunners()
                    }
                    .onChange(of: meetName) { newValue in
                        refreshMeetResults()
                    }
                
                if (!meetName.isEmpty) {
                    NavigationView {
                        
                        List {
                            ForEach(totalMeetPerformancesDTOs) { result in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(result.runner.name)
                                        Spacer()
                                        
                                        if (authentication.user?.role != "runner") {
                                            Button() {
                                                viewModel = AddRunnerMeetResultFormViewModel(runner: result.runner, season: season, performanceDTO: result.performance)
                                                runnerName = result.runner.name + ":" + result.runner.graduatingClass
                                                showSheet = true
                                            } label: {
                                                Text("Edit")
                                            }
                                        }
                                    }.padding(.bottom, 5)
                                   
//                                    MeetResultView(result: MeetResult(meetDate: result.performance.meetDate, meetName: result.performance.meetName, place: result.performance.place, time: result.performance.time))
                                    
                                    TotalMeetResultView(result: result.performance)
                                    
                                }.listRowSeparator(.hidden)
                                
                                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1)
                                
                            }
                            
                        }.environment(\.colorScheme, .light)
                        
                        
                    }.toolbar {
                        
                        if (authentication.user?.role != "runner") {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    viewModel = AddRunnerMeetResultFormViewModel(runner: runner, meet: meetName, season: season)
                                    showSheet.toggle()
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .imageScale(.large)
                                }
                                .sheet(isPresented: $showSheet, onDismiss: refreshMeetResults) {
                                    AddRunnerMeetResultsFormView(showSheet: $showSheet, season: $season, meet: $meetName, runners: $runners, runnerName: runnerName, viewModel: viewModel)
                                        .preferredColorScheme(.light)
                                }
                            }
                        }

                    }
                } else {
                    Spacer()
                }
            }
        }
    }
}

//struct AddMeetResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMeetResultsView()
//    }
//}
