//
//  WorkoutComponentView.swift
//  UAXC
//
//  Created by David  Terkula on 10/30/22.
//

import SwiftUI

class SplitsListViewModel: ObservableObject {
    @Published var splits: [SplitViewModel] = []
}

class SplitViewModel: ObservableObject, Identifiable {
    
    var id = UUID()
    
    var uuid: String
    @Published var number: Int
    @Published var time: String
    
    init(_ splitElement: SplitElement) {
        self.uuid = splitElement.uuid
        self.number = splitElement.number
        self.time = splitElement.time
   }
    
}

struct SplitRow: View {
    
    var number: Int
    var time: String
    
    var body: some View {
        HStack {
            Text(String(number) + ": ")
            Text(time)
        }
    }
}

struct EditableSplitRowView: View {
    @ObservedObject var viewModel: SplitViewModel
    
    var body: some View {
        HStack {
            Text(String(viewModel.number) + ": ")
            TextField("Split", text: $viewModel.time)
                .keyboardType(.numbersAndPunctuation)
                .onChange(of: viewModel.time) { [time] newValue in
                    // viewModel.validSplits = false
                   }
            //SplitTimePicker(minutesValue: $minutesValue, secondsValue: $secondsValue)
        }
    }
}

struct WorkoutComponentSplitView: View {
    
    var component: WorkoutComponent
    @Binding var runner: Runner
    @EnvironmentObject var authentication: Authentication
    @State private var showingSheet = false
    
    var splitsResponse: SplitsResponse?
    
    @ObservedObject var splitsViewModel: SplitsListViewModel
    
    let dataService = DataService()
   
    
    var body: some View {
        VStack {
            
            HStack {
                Text(component.description)
                Text("@ " + component.pace + " pace")
            }
            
            if (component.duration == nil) {
                Text("Target Count: " + String(component.targetCount))
            } else {
                Text("Target Duration: " + component.duration!)
            }
            
            Text("Splits").padding(.top, 5)
            Button() {
                showingSheet.toggle()
            } label: {
              // Image(systemName: "plus.circle.fill").imageScale(.large)
            }.sheet(isPresented: $showingSheet) {
                AddSplitSheetView(component: component, runner: runner, splitsViewModel: splitsViewModel).preferredColorScheme(.light)
            }

            SplitsListView(splitsViewModel: splitsViewModel)
                .padding(.top, -20)
            
        } // end vstack
//        .onAppear {
//            // TODO put this in a button and have the button be pushed after every name change.
//            
//            dataService.getSplits(runnerId: runner.runnerId, componentUUID: component.uuid.uuidString) { (result) in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let response):
//                        splitsViewModel.splits = response.splits.map{ SplitViewModel($0) }
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
//        }
    }
}

//struct WorkoutComponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutComponentView()
//    }
//}
