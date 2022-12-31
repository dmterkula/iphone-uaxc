//
//  AddSplitsCoachesView.swift
//  UAXC
//
//  Created by David  Terkula on 12/17/22.
//

import SwiftUI

struct AddSplitsCoachesView: View {
    var workout: Workout

    @State var componentToSplits: [WorkoutComponent:SplitsListViewModel] = [WorkoutComponent:SplitsListViewModel]()
    
    let dataService = DataService()
    
    @EnvironmentObject var authentication: Authentication
    
    @State var showEditSheet: Bool = false
    
    @State var workoutResultsResponse: ARunnersWorkoutResultsResponse? = nil
    
    @State var viewModel = RunnerWorkoutFormViewModel()
    
    @State var runners: [Runner] = []
    @State var runnerName: String = ""
    @State var runner: Runner? = nil
    @State var filterName: String = ""
    @State var retrievingViewModel = false
    
    func closeEditSheet() {
        showEditSheet = false
    }
    
    func fetchRunners() {
        
        if (authentication.user?.role == "runner" && authentication.runner != nil) {
            runner = authentication.runner!
            runnerName = runner!.name
        } else {
            
            if (runner != nil) { // coming from profile as a coach, preload the selected runner
                runnerName = runner!.name
                getRunnersDataInitialLoad(selectedRunner: runner!)
                retrievingViewModel = true
            }
            else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                let yearString = dateFormatter.string(from: workout.date)
                
                dataService.fetchPossibleRunners(season: yearString, filterForIsActive: true) { (result) in
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
        }

    }

    
    func getRunnersData(selectedRunner: Runner) {
        runner = selectedRunner
        dataService.getARunnersWorkoutResults(workoutUuid: workout.uuid.uuidString, runnerId: selectedRunner.runnerId) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.workoutResultsResponse = response
                    viewModel = RunnerWorkoutFormViewModel(distance: response.totalDistance, compToSplits: Dictionary(uniqueKeysWithValues: response.componentResults.map { (workout.getComponentFromId(uuid: $0.componentUUID), $0.splits.toSplitsViewModel()) })
                    )
                    retrievingViewModel = false
                case .failure(let error):
                    print(error)
                }
               
            }
        }
    }
    
    func getRunnersDataInitialLoad(selectedRunner: Runner) {
        runner = selectedRunner
        dataService.getARunnersWorkoutResults(workoutUuid: workout.uuid.uuidString, runnerId: selectedRunner.runnerId) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.workoutResultsResponse = response
                    viewModel = RunnerWorkoutFormViewModel(distance: response.totalDistance, compToSplits: Dictionary(uniqueKeysWithValues: response.componentResults.map { (workout.getComponentFromId(uuid: $0.componentUUID), $0.splits.toSplitsViewModel()) })
                    )
                    retrievingViewModel = false
                    showEditSheet = true
                case .failure(let error):
                    print(error)
                }
               
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all).onAppear {
                    fetchRunners()
                }
                VStack {
                        Text(workout.date.formatted(date: .abbreviated,
                                                    time: .omitted))
                        .foregroundColor(.white)
                        Text(workout.title)
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text(workout.title)
                            .font(.title3)
                            .foregroundColor(.white)
                      .padding(.bottom, 10)
                    
                    Text("Select a runner to view their splits")
                        .padding(.bottom, 5)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.top, 30)
                       
                    FilterRunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                        .padding(.bottom, 5)
                        .onChange(of: runnerName) { [runnerName] newValue in
                            retrievingViewModel = true
                            
                            if (newValue.contains(":")) {
                                // then chance came from runnerPicker
                                getRunnersData(selectedRunner: runners.first(where: {$0.name == newValue.components(separatedBy: ":")[0]})!)
                            } else {
                                // noop as page is loading from profile page as coach and runner is already assigned
                            }
                            
                           
                        }
                    
                    if (!runnerName.isEmpty) {
                        Button() {
                            showEditSheet = true
                        } label: {
                            Text("Add/Edit Workout Results")
                                .foregroundColor(GlobalFunctions.gold())
                        }
                        .disabled(retrievingViewModel)
                        .sheet(isPresented: $showEditSheet, onDismiss: closeEditSheet) {
                            RunnerWorkoutEditFormView(workout: workout, runner: runner!, viewModel: $viewModel, showEditSheet: $showEditSheet)
                                .preferredColorScheme(.light)
                        
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                
            }
        }
    }
}

//struct AddSplitsCoachesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSplitsCoachesView()
//    }
//}
