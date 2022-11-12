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
                    
                    List {
                        ForEach(workout.components) { component in
                            WorkoutComponentRowView(component: component)
                                .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                .preferredColorScheme(.light)
                        }
                    }
                    .frame(width: geometry.size.width * 0.90)
                    .frame(maxHeight: geometry.size.height * 0.50)
                    
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
