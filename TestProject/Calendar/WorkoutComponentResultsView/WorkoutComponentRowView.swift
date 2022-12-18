//
//  WorkoutComponentRowView.swift
//  UAXC
//
//  Created by David  Terkula on 11/6/22.
//

import SwiftUI

struct WorkoutComponentRowView: View {
    
    var component: WorkoutComponent
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
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
            }
            
            
            NavigationLink(destination: IndividualComponentResultsView(component: component).environment(\.colorScheme, .light)) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())
            
        }

    }
}

struct WorkoutComponentRowV2View: View {
    
    var component: WorkoutComponent
    
    var body: some View {
        
        Form() {
            Section(header:  NavigationLink(destination: IndividualComponentResultsView(component: component).environment(\.colorScheme, .light)) {
                HStack {
                    Text("View Results")
                    Image(systemName: "chevron.right")  
                }
                
                   
            }) {
                HStack {
                    VStack(alignment: .leading) {
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
                    }
      
                }
            }
        }
        .frame(height: 120)
        .textCase(nil)

    }
}

//struct WorkoutComponentRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutComponentRowView()
//    }
//}
