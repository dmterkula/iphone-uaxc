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

    init(_ split: Split) {
        self.uuid = split.uuid
        self.number = split.number
        self.time = split.value
   }

}


class DoubleSplitViewModel: ObservableObject, Identifiable, Equatable {
    
    var id = UUID()
    
    var uuid: String
    @Published var number: Int
    @Published var minutes: Int
    @Published var seconds: Int
    
    init(_ splitElement: SplitElement) {
        self.uuid = splitElement.uuid
        self.number = splitElement.number
        self.minutes = splitElement.time.getMinutesFrom()
        self.seconds = splitElement.time.getSecondsFrom()
   }
    
    init(_ split: Split) {
        self.uuid = split.uuid
        self.number = split.number
        self.minutes = split.value.getMinutesFrom()
        self.seconds = split.value.getSecondsFrom()
   }
    
    func getMinuteSecondString() -> String {
        return (minutes * 60 + seconds).toMinuteSecondString()
    }

    static func ==(lhs: DoubleSplitViewModel, rhs: DoubleSplitViewModel) -> Bool {
        return lhs.number == rhs.number && lhs.minutes == rhs.minutes && lhs.seconds == rhs.seconds
    }
    
}


struct WorkoutSplitRowView: View {
    @ObservedObject var viewModel: DoubleSplitViewModel
    
    var body: some View {
        HStack {
            Text(String(viewModel.number) + ": ")
            WorkoutSplitTimePicker(minutes: $viewModel.minutes, seconds: $viewModel.seconds)
 
        }
    }
}

struct WorkoutComponentSplitsView: View {
    @ObservedObject var overallViewModel: EditingRunnerWorkoutFormViewModel
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var key: WorkoutComponent
    
    var body: some View {
    
        NavigationStack() {
            List {
                ForEach(overallViewModel.componentToSplits[key]!) {doubleSplitViewModel in
                    WorkoutSplitRowView(viewModel: doubleSplitViewModel)
                }.onMove { indexSet, offset in
                    overallViewModel.componentToSplits[key]!.move(fromOffsets: indexSet, toOffset: offset)
                    overallViewModel.componentToSplits[key]! = overallViewModel.componentToSplits[key]!.mapWithIndex{ (index, element) in
                        DoubleSplitViewModel(Split(uuid: element.uuid, number: index + 1, value: element.getMinuteSecondString()))
                    }
                }
                .onDelete { indexSet in
                    overallViewModel.componentToSplits[key]!.remove(atOffsets: indexSet)
                    overallViewModel.componentToSplits[key]! = overallViewModel.componentToSplits[key]!.mapWithIndex{ (index, element) in
                        DoubleSplitViewModel(Split(uuid: element.uuid, number: index + 1, value: element.getMinuteSecondString()))
                    }
                    
                }
            }.environment(\.editMode, Binding.constant(EditMode.active))
            
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action : {
                overallViewModel.componentToSplits = overallViewModel.componentToSplits
                self.mode.wrappedValue.dismiss()
            }){
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                }
            },
                trailing:  Button() {
                overallViewModel.componentToSplits[key]!.append(DoubleSplitViewModel(Split(uuid: UUID().uuidString, number: overallViewModel.componentToSplits[key]!.count + 1, value: "00:00")))
            } label: {
                Image(systemName: "plus.circle.fill").imageScale(.large)
            })
            .navigationTitle(Text("Add Splits"))
        }
       
    }
    
    func move(from source: IndexSet, to destination: Int) {
        overallViewModel.componentToSplits[key]!.move(fromOffsets: source, toOffset: destination)
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


//struct WorkoutComponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutComponentView()
//    }
//}
