//
//  AddSplitsView.swift
//  UAXC
//
//  Created by David  Terkula on 10/30/22.
//

import SwiftUI

struct AddSplitsView: View {
    
    var workout: Workout
    
    @State var runners: [Runner] = []
    @State var runnerName: String = ""
    @State var runner: Runner? = nil
    @State var filterName: String = ""
    
    @State var componentToSplits: [WorkoutComponent:SplitsListViewModel] = [WorkoutComponent:SplitsListViewModel]()
    
    let dataService = DataService()
    
    @EnvironmentObject var authentication: Authentication
    
    func fetchRunners() {
        
        if (authentication.user?.role == "runner" && authentication.runner != nil) {
            runner = authentication.runner!
            runnerName = runner!.name
        } else {
            
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
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear{
                        fetchRunners()
                    }
                
                VStack {
                    if (authentication.user != nil && authentication.user!.role == "runner" && authentication.runner != nil) {
                        Text(authentication.runner!.name + "'s Goals")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    } else {
                        
                        Text("Select a runner to view their splits")
                            .padding(.bottom, 5)
                            .foregroundColor(.white)
                            .font(.title2)
                           
                        FilterRunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                            .padding(.bottom, 5)
                            .onChange(of: runnerName) { [runnerName] newValue in
                                
                                for component in workout.components {
                                    
                                    let selectedRunner = ($runners.filter{$0.wrappedValue.name == newValue.components(separatedBy: ":")[0]}.first)!
                                    
                                    dataService.getSplits(runnerId: selectedRunner.wrappedValue.runnerId, componentUUID: component.uuid.uuidString) { (result) in
                                        DispatchQueue.main.async {
                                            switch result {
                                            case .success(let response):
                                                let viewModel = SplitsListViewModel()
                                                viewModel.splits = response.splits.map { SplitViewModel($0) }
                                                componentToSplits[component] = viewModel
                                            case .failure(let error):
                                                print(error)
                                            }
                                        }
                                    }
                                    
                                }
                                
                            }
                    }
                    
    
                    if (!runnerName.isEmpty && componentToSplits.count == workout.components.count) {
                        List {
                            ForEach(workout.components) { component in
                                if (runner != nil) {
                                    
                                    let viewModel = componentToSplits[component]!
                                    let boundRunner: Binding<Runner> = Binding($runner)!
                                    
                                    WorkoutComponentSplitView(component: component, runner: boundRunner, splitsViewModel: viewModel)
                                        .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                        .padding(.bottom, 5)
                                        .onTapGesture {
                                            hideKeyboard()
                                        }
                                    
                                } else {
                                    
                                    let selectedRunner = ($runners.filter{$0.wrappedValue.name == runnerName.components(separatedBy: ":")[0]}.first)!
                                    
                                    let viewModel = componentToSplits[component]!
                                    
                                    WorkoutComponentSplitView(component: component, runner: selectedRunner, splitsViewModel: viewModel)
                                        .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                        .padding(.bottom, 5)
                                        .onTapGesture {
                                            hideKeyboard()
                                        }
                                }
                            }
                            .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                                dimensions[.leading]
                           }
                        }
                        .frame(width: geometry.size.width * 0.90)
                        
                    }
                    
                    Spacer()
                    
                }
                
            }
        }
    }
}

//struct AddSplitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSplitsView()
//    }
//}
