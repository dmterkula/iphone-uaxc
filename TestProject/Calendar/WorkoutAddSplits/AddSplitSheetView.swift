//
//  AddSplitSheetView.swift
//  UAXC
//
//  Created by David  Terkula on 10/30/22.
//

import SwiftUI

struct AddSplitSheetView: View {
    
    
    var component: WorkoutComponent
    var runner: Runner
    @ObservedObject var splitsViewModel: SplitsListViewModel
    
    @State private var showingAlert = false
    @State private var validSplits = false
    
    let dataService = DataService()

    
    func refreshSplits() {
        dataService.getSplits(runnerId: runner.runnerId, componentUUID: component.uuid.uuidString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    splitsViewModel.splits.removeAll()
                    splitsViewModel.splits.append(contentsOf: response.splits.map{SplitViewModel($0)})
                
                    case .failure(let error):
                        print(error)
                }
            }
            
        }
    }
    
    func validateSplits() {
        
        if (!splitsViewModel.splits.allSatisfy{$0.time.isValidTime()}) {
            showingAlert = true
            validSplits = false
        } else {
            validSplits = true
            showingAlert = false
        }
    }
    
    func saveSplits() {
        
        let splits = splitsViewModel.splits.map {
            Split(uuid: UUID().uuidString, number: $0.number, value: $0.time)
        }
        
        dataService.createSplit(runnerId: runner.runnerId, componentUUID: component.uuid.uuidString, splits: splits) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.refreshSplits()
                    print(response)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func moveSplit(source: IndexSet, destination: Int) {
        splitsViewModel.splits.move(fromOffsets: source, toOffset: destination)
        splitsViewModel.splits = splitsViewModel.splits.mapWithIndex { (index, element) in
            SplitViewModel(SplitElement(uuid: element.uuid, number: index + 1, time: element.time))
        }
    }
    
    func deleteSplit(offsets: IndexSet) {
        
        // TODO reset split number on deletion
        
        let splitToBeDeleted: SplitViewModel = splitsViewModel.splits[offsets.first!]
        
        let requestObject: SplitElement = SplitElement(uuid: splitToBeDeleted.uuid, number: splitToBeDeleted.number, time: splitToBeDeleted.time)
        
        splitsViewModel.splits.remove(at: offsets.first!)
        
        splitsViewModel.splits = splitsViewModel.splits.mapWithIndex { (index, element) in
            SplitViewModel(SplitElement(uuid: element.uuid, number: index + 1, time: element.time))
        }
        dataService.deleteSplit(split: requestObject) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                   print(response)
                    case .failure(let error):
                        print(error)
                }
            }
            
        }
        
    }
    
    var body: some View {
        
        VStack {
            Text("Add Splits for " + runner.name)
            Text(component.description)
            HStack {
                Text("Target Pace: " + component.pace)
                if (!component.isPaceAdjustment0()) {
                    if (!component.isPaceAdjustmentFaster()) {
                        Text("+ " + component.targetPaceAdjustment)
                    } else {
                        Text(component.targetPaceAdjustment)
                    }
                }
               
            }
          
            if (component.type == "Interval") {
                Text("Target Count: " + String(component.targetCount))
            }
            
            Button() {
                splitsViewModel.splits.append(SplitViewModel(SplitElement(uuid: UUID().uuidString, number: splitsViewModel.splits.count + 1, time: "0:00.0")))
            } label: {
                Text("Add Split")
            }
            
            List {
                ForEach(splitsViewModel.splits) { split in
                    EditableSplitRowView(viewModel: split)
                }
                .onMove(perform: moveSplit)
                .onDelete(perform: deleteSplit)
            }
            .environment(\.defaultMinListRowHeight, 100)
            .environment(\.editMode, Binding.constant(EditMode.active))
            
            HStack {
                Button() {
                    validateSplits()
                } label: {
                    Text("Validate Splits")
                }
                .alert("Not all splits have a valid time format. Splits should be of the form 'mm:ss.sss'", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .padding(.trailing, 20)
                
                
                Button() {
                    saveSplits()
                } label: {
                    Text("Save Splits")
                }
                .disabled(!validSplits)
                
            }
            
      
            
        }
        .padding(.top, 10)
        .onAppear {
           // splits = dataService.getSplits(runnerId: work, componentUUID: <#T##String#>, completition: <#T##(Result<SplitsResponse, Error>) -> Void#>)
        }
    }
}

//struct AddSplitSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSplitSheetView()
//    }
//}
