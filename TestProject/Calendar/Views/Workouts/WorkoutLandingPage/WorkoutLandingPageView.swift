//
//  WorkoutLandingPageView.swift
//  UAXC
//
//  Created by David  Terkula on 10/30/22.
//

import SwiftUI

struct WorkoutLandingPageView: View {
    
    var workout: Workout
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        ZStack(alignment: .center) {
            Background().edgesIgnoringSafeArea(.all)
            
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
                
                Spacer()
                
            }.padding(.bottom, 10)
            
            TabView {
                
                WorkoutPlanView(workout: workout)
                    .tabItem {
                        Label("Workout Plan", systemImage: "book.circle")
                           Text("Workout Plan")
                    }
                
                if (authentication.user!.role == "coach") {
                    AddSplitsCoachesView(workout: workout)
                        .tabItem {
                            Label("Add Splits", systemImage: "pencil.circle")
                               Text("Splits")
                        }
                    
                } else {
                    AddSplitsRunnersView(workout: workout)
                        .tabItem {
                            Label("Add Splits", systemImage: "pencil.circle")
                               Text("Splits")
                        }
                }

                ComponentsResultsView(workout: workout)
                    .tabItem {
                        Label("Team Results", systemImage: "figure.run.circle")
                           Text("Team Results")
                    }
                
            }
            
        }
       
    }
}


//struct WorkoutLandingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutLandingPageView()
//    }
//}
