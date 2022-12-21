//
//  ComponentsResultsView.swift
//  UAXC
//
//  Created by David  Terkula on 11/6/22.
//

import SwiftUI

struct ComponentsResultsView: View {
    
    var workout: Workout
    
    let dataService = DataService()
    
    func calcListHeight() -> Double {
        if (workout.components.count <= 1) {
            return 0.33
        } else if (workout.components.count == 2) {
            return 0.50
        } else {
            return 0.60
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Workout Results " + workout.icon)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text(workout.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.largeTitle).padding(.bottom, 10)
                        .foregroundColor(.white)
                    
                    Form {
                        ForEach(workout.components) { component in
                            WorkoutComponentRowView(component: component)
                                .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                .preferredColorScheme(.light)
                        }
                    }
                    .textCase(nil)
                    .frame(width: geometry.size.width * 0.90)
                    .frame(maxHeight: geometry.size.height * calcListHeight())
                    
                }
            }
        }
    }
}


//struct ComponentsResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComponentsResultsView()
//    }
//}
