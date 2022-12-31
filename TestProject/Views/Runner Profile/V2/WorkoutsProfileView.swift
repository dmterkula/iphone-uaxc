//
//  WorkoutsProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 12/28/22.
//

import SwiftUI

struct WorkoutsProfileView: View {
    
    var workoutResults: [ARunnersWorkoutResultsResponse]
    
    var body: some View {
        ForEach(workoutResults) { result in
            WorkoutProfileRowView(workoutResult: result)
                .listRowSeparator(.hidden)
            CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
        }
    }
    
    
}

struct WorkoutProfileRowView: View {
    
    @EnvironmentObject var authentication: Authentication
    var workoutResult: ARunnersWorkoutResultsResponse
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(workoutResult.workout.date.formatted(date: .complete, time: .omitted))
                    .bold()
                
                if (authentication.user?.role == "runner") {
                    NavigationLink(destination: AddSplitsRunnersView(workout: workoutResult.workout).environment(\.colorScheme, .light)) {
                    }
                } else if (authentication.user?.role == "coach") {
                    
                    NavigationLink(destination: AddSplitsCoachesView(workout: workoutResult.workout, runner: workoutResult.runner).environment(\.colorScheme, .light)) {
                    }
                    
                }
                
                
            }
            
            Text(workoutResult.workout.description)
            
            HStack {
                Text("Total Distance Logged:")
                Text(String(workoutResult.totalDistance.rounded(toPlaces: 2)))
            }
            
            
        }
        
    }
    
}

//struct WorkoutsProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutsProfileView()
//    }
//}
