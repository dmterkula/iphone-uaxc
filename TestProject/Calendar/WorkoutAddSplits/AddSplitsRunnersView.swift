//
//  AddSplitsRunnersView.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import SwiftUI

struct AddSplitsRunnersView: View {
    
    var workout: Workout

    @State var componentToSplits: [WorkoutComponent:SplitsListViewModel] = [WorkoutComponent:SplitsListViewModel]()
    
    let dataService = DataService()
    
    @EnvironmentObject var authentication: Authentication
    
    @State var showEditSheet: Bool = false
    
    @State var workoutResultsResponse: ARunnersWorkoutResultsResponse? = nil
    
    @State var viewModel = RunnerWorkoutFormViewModel()
    
    func closeEditSheet() {
        showEditSheet = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear {
                        dataService.getARunnersWorkoutResults(workoutUuid: workout.uuid.uuidString, runnerId: authentication.runner!.runnerId) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.workoutResultsResponse = response
                                    viewModel = RunnerWorkoutFormViewModel(distance: response.totalDistance, compToSplits: Dictionary(uniqueKeysWithValues: response.componentResults.map { (workout.getComponentFromId(uuid: $0.componentUUID), $0.splits.toSplitsViewModel()) })
                                    )
                                case .failure(let error):
                                    print(error)
                                }
                               
                            }
                        }
                    } // end on appear
                
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
                    
                    Button() {
                        showEditSheet = true
                    } label: {
                        Text("View/Log your workout results")
                            .foregroundColor(GlobalFunctions.gold())
                    }
                    .sheet(isPresented: $showEditSheet, onDismiss: closeEditSheet) {
                        RunnerWorkoutEditFormView(workout: workout, runner: authentication.runner!, viewModel: $viewModel, showEditSheet: $showEditSheet)
                            .preferredColorScheme(.light)
                    }
                }
                
            }
        }
    }
}





//struct AddSplitsRunnersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSplitsRunnersView()
//    }
//}
