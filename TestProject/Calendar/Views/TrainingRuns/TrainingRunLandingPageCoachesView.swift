//
//  TrainingRunLandingPageCoachesView.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import SwiftUI

struct TrainingRunLandingPageCoachesView: View {
    
    var trainingRunEvent: TrainingRunEvent
    @State
    var trainingRunResponse: RunnerTrainingRunResponse? = nil
    
    let dataService = DataService()
    
    @State
    var sortByGradClass: Bool = false
    
    @State
    var sortByTime: Bool = false
    
    @State
    var sortByDistance: Bool = false
    
    @State
    var sortByPace: Bool = false
    
    @State var runners: [Runner] = []
    
    @EnvironmentObject var runnerStore: RunnerStore
    
    @State var addTrainingRunData = false
    
    @State var runnerName = ""
    
    
    func refreshTrainingRun() {
        dataService.getAllTrainingRunResultsForGivenPractice(trainingRunUUID: trainingRunEvent.uuid) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        trainingRunResponse = response
                        print(response)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
    
    func toggleSheet() {
        addTrainingRunData .toggle()
    }
    
    func getRunners() {
        dataService.fetchPossibleRunners(season: trainingRunEvent.date.getYear(), filterForIsActive: true) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let runnersResponse):
                    self.runners = runnersResponse
                case .failure(let error):
                    print(error)
                }
            }
        }

    }
    
    var body: some View {
        GeometryReader { geometry in
            
                
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear {
                        refreshTrainingRun()
                        getRunners()
                    }
                
                VStack {
                    Text(trainingRunEvent.title)
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Text(trainingRunEvent.date.formatted(date: .abbreviated,
                                                         time: .omitted))
                    .foregroundColor(.white)
                    .font(.title)
                    
                    VStack {
                        if (trainingRunEvent.distance != nil) {
                            HStack {
                                Text("Target Distance: ")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                Text(String(trainingRunEvent.distance!) + " miles")
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                        }
                        
                        if (trainingRunEvent.time != nil) {
                            HStack {
                                Text("Target Duration: ")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                Text(trainingRunEvent.time!)
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                        }
                    }
                    
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            CheckBoxView(checked: $sortByTime)
                            Text("Sort by time")
                            Spacer()
                        }.onChange(of: sortByTime) { [sortByTime] newValue in
                            if (newValue == true) {
                                sortByDistance = false
                                sortByGradClass = false
                                sortByPace = false
                                
                                if (trainingRunResponse != nil && !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                                    trainingRunResponse!.runnerTrainingRuns = trainingRunResponse!.runnerTrainingRuns.sorted(by: {$0.time < $1.time })
                                }
                                
                            }
                            
                           
                        }
                        
                        HStack {
                            Spacer()
                            CheckBoxView(checked: $sortByDistance)
                            Text("Sort by distance")
                            Spacer()
                        }.onChange(of: sortByDistance) { [sortByDistance] newValue in
                            if (newValue == true) {
                                sortByTime = false
                                sortByGradClass = false
                                sortByPace = false
                                
                                if (trainingRunResponse != nil && !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                                    trainingRunResponse!.runnerTrainingRuns = trainingRunResponse!.runnerTrainingRuns.sorted(by: {$0.distance < $1.distance })
                                }
                                
                            }
                            
                            
                        }
                        
                        HStack {
                            Spacer()
                            CheckBoxView(checked: $sortByGradClass)
                            Text("Sort by class")
                            Spacer()
                        }.onChange(of: sortByGradClass) { [sortByGradClass] newValue in
                            if (newValue == true) {
                                sortByDistance = false
                                sortByTime = false
                                sortByPace = false
                                
                                if (trainingRunResponse != nil && !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                                    trainingRunResponse!.runnerTrainingRuns = trainingRunResponse!.runnerTrainingRuns.sorted(by: {$0.runner.graduatingClass > $1.runner.graduatingClass})
                                }
                                
                            }
                        }
                        
                        
                        HStack {
                            Spacer()
                            CheckBoxView(checked: $sortByPace)
                            Text("Sort by pace")
                            Spacer()
                        }.onChange(of: sortByPace) { [sortByPace] newValue in
                            if (newValue == true) {
                                sortByDistance = false
                                sortByTime = false
                                sortByGradClass = false
                                
                                if (trainingRunResponse != nil && !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                                    trainingRunResponse!.runnerTrainingRuns = trainingRunResponse!.runnerTrainingRuns.sorted(by: {$0.avgPace < $1.avgPace})
                                }
                                
                            }
                        }
                        
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                   
                    
                    Form {
                        
                        Section(header:
                                    HStack {
                            Spacer()
                            Button() {
                                addTrainingRunData.toggle()
                            } label : {
                                Image(systemName: "plus.circle.fill").imageScale(.large)
                            }
                            }
                        
                        ) {
                            
                        }
                        
                        if (trainingRunResponse != nil) {
                            ForEach(trainingRunResponse!.runnerTrainingRuns) { runnersloggedRun in
                                RunnersLoggedTrainingRunRow(runnersLoggedTrainingRun: runnersloggedRun, trainingRunEvent: trainingRunEvent)
                            }
                        }
                    }
                    
                    .frame(width: geometry.size.width * 0.95)
                    
                    
                    
                } // end vstack
                .sheet(isPresented: $addTrainingRunData, onDismiss: refreshTrainingRun) {
                    CoachAddRunnersTrainingRunView(trainingRunEvent: trainingRunEvent, runners: $runners, runnerName: $runnerName).environment(\.colorScheme, .light)
                }
                
                
                
            } // end zstack
            
        } // end geometry
    } // end body view
}

//struct TrainingRunLandingPageCoachesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingRunLandingPageCoachesView()
//    }
//}
