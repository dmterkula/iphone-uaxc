//
//  IndividualComponentResults.swift
//  UAXC
//
//  Created by David  Terkula on 11/6/22.
//

import SwiftUI

struct IndividualComponentResultsView: View {
    
    let dataService = DataService()
    var component: WorkoutComponent
    
    @State var componentResults: WorkoutComponentSplitsResponse?
    
    func fetchComponentResults() {
        
        dataService.getWorkoutComponentResults(componentUUID: component.uuid.uuidString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    componentResults = results
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
                        fetchComponentResults()
                    }
                VStack {
                    VStack {
                        Text(component.description)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        HStack {
                            Text("Target Pace: " + component.pace)
                                .foregroundColor(.white)
                            if (!component.isPaceAdjustment0()) {
                                if (!component.isPaceAdjustmentFaster()) {
                                    Text("+ " + component.targetPaceAdjustment)
                                        .foregroundColor(.white)
                                } else {
                                    Text(component.targetPaceAdjustment)
                                        .foregroundColor(.white)
                                }
                            }
                           
                        }
                      
                        if (component.type == "Interval") {
                            Text("Target Count: " + String(component.targetCount))
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                    if (componentResults != nil) {
                        List {
                            ForEach(componentResults!.results) { result in
                                RunnerWorkoutComponentResultView(component: component, result: result)
                                .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                            }
                        }.frame(maxWidth: geometry.size.width * 0.90)
                       
                    }
                }
            }
        }
    }
}

//struct IndividualComponentResults_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualComponentResults()
//    }
//}
