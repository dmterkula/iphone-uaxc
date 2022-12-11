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
    
    @State var cantAddData = false
    @State var showAlert = false
    @State var showingSheet = false
    
    @EnvironmentObject var authentication: Authentication
    
    func refreshTrainingRun() {
        dataService.getRunnersTrainingRun(runnerId: authentication.runner!.runnerId, trainingRunUUID: trainingRunEvent.uuid) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        trainingRunResponse = response
                        if (Date() < trainingRunEvent.date || !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                            cantAddData = true
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
                            refreshTrainingRun()
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
                        
                        //                Button() {
                        //
                        //                } label: {
                        //                    Text("Log Run")
                        //                        .font(.title3)
                        //                        .fontWeight(.bold)
                        //                        .accentColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        //                }
                        //                .padding()
                        //                .overlay(
                        //                    RoundedRectangle(cornerRadius: 20)
                        //                        .stroke(Color(red: 249/255, green: 229/255, blue: 0/255), lineWidth: 5)
                        //                        )
                        
                        
                        if (trainingRunResponse != nil && !trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                            Button {
                                showingSheet.toggle()
                            } label: {
                                LoggedTrainingRunView(loggedRun: trainingRunResponse!.runnerTrainingRuns.first!, geometry: geometry)
                                    .padding(.top, 30)
                            }.accentColor(.white)
                            
                            
                        }
                        
                        Spacer()
                        
                        
                        
                    } // end VStack
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                if (!cantAddData) {
                                    showAlert = false
                                    showingSheet.toggle()
                                } else {
                                    showAlert = true
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .alert("Cannot add training run data. either this training run occurs in future or you have already logged the maximum number of runs for this practice", isPresented: $showAlert) {
                                Button("OK", role: .cancel) {
                                }
                            }
                            .sheet(isPresented: $showingSheet, onDismiss: refreshTrainingRun) {
                                
                                if (trainingRunResponse == nil || trainingRunResponse!.runnerTrainingRuns.isEmpty) {
                                    LogTrainingRunFormView(viewModel: RunnersTrainingRunFormViewModel(runner: authentication.runner!, trainingRunUuid: trainingRunEvent.uuid)).preferredColorScheme(.light)
                                } else {
                                    LogTrainingRunFormView(viewModel: RunnersTrainingRunFormViewModel(trainingRunResponse!.runnerTrainingRuns.first!)).preferredColorScheme(.light)
                                }
                                
                               
                            }
                            
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
