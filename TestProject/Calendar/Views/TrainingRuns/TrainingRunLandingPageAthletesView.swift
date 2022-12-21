//
//  TrainingRunLandingPage.swift
//  UAXC
//
//  Created by David  Terkula on 11/26/22.
//

import SwiftUI

struct TrainingRunLandingPageAthletesView: View {
    
    var trainingRunEvent: TrainingRunEvent
    
    @State
    var trainingRunResponse: RunnerTrainingRunResponse? = nil
    
    let dataService = DataService()
    
    @State var showEditSheet = false
    @State var retrievingTrainingRunData = false
    
    @State var viewModel = RunnersTrainingRunFormViewModel()
    
    var runner: Runner
    
    @EnvironmentObject var authentication: Authentication
    
    
    func getTitle() -> String {
        if(authentication.user!.role == "coach") {
            if(viewModel.runner.name.last! == "s") {
                return "Edit " + viewModel.runner.name + "' run"
            } else {
                return "Edit " + viewModel.runner.name + "'s run"
            }
           
        } else {
            return "Log your run"
        }
    }
    
    func refreshTrainingRun() {
        dataService.getRunnersTrainingRun(runnerId: runner.runnerId, trainingRunUUID: trainingRunEvent.uuid) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        retrievingTrainingRunData = false
                        trainingRunResponse = response
                        if (response.runnerTrainingRuns.isEmpty) {
                            viewModel = RunnersTrainingRunFormViewModel(runner: runner, trainingRunUuid: trainingRunEvent.uuid)
                        } else {
                            viewModel = RunnersTrainingRunFormViewModel(response.runnerTrainingRuns.first!)
                        }
                        
                        print(response)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationStack {
                
                ZStack(alignment: .center) {
                    Background().edgesIgnoringSafeArea(.all)
                        .onAppear {
                            retrievingTrainingRunData = true
                            refreshTrainingRun()
                        }
                    
                    VStack {
                        Text(trainingRunEvent.title)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 5)
                        
                        Text(trainingRunEvent.date.formatted(date: .abbreviated,
                                                             time: .omitted))
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.bottom, 5)
                        
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
                        
                        if (!viewModel.isComplete()) {
                            
                            Button {
                                showEditSheet.toggle()
                            } label: {
                                Text(getTitle())
                                    .foregroundColor(GlobalFunctions.gold())
                            }
                            .padding(.top, 20)
                            .disabled(retrievingTrainingRunData)
                        } else {
                            Form {
                                
                                Section(header:
                                            HStack {
                                    Button {
                                        showEditSheet.toggle()
                                    } label: {
                                        Text("Edit")
                                    }
                                    .padding(.top, 20)
                                    .disabled(retrievingTrainingRunData)
                                }
                                
                                ) {
                                    
                                }
                                
                                Section(header: Text("Distance")) {
                                    Text(String(viewModel.calcDistance()))
                                }
                                
                                Section(header: Text("Time")) {
                                    Text(viewModel.getTimeString())
                                }
                                
                                Section(header: Text("Avg. Pace Per Mi")) {
                                    Text(viewModel.calcAveragePace())
                                }
                            }
                            .frame(width: geometry.size.width * 0.95)
                            
                        }

                        
                        Spacer()
                             
                    } // end VStack
                    .sheet(isPresented: $showEditSheet) {
                        
                        if (trainingRunResponse == nil || trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                            LogTrainingRunFormView(viewModel: $viewModel, showEditSheet: $showEditSheet).preferredColorScheme(.light)
                        } else {
                            LogTrainingRunFormView(viewModel: $viewModel, showEditSheet: $showEditSheet).preferredColorScheme(.light)
                        }
                        
                       
                    }
                }
            } // end navigation stack
        }
    }
}

//struct TrainingRunLandingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingRunLandingPage()
//    }
//}
