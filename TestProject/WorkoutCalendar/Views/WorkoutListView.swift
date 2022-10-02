//
//  WorkoutListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutListView: View {
    @EnvironmentObject var myWorkouts: WorkoutStore
    @State private var formType: WorkoutFormType?
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Workouts")
                    .font(.system(.largeTitle, design: .rounded))
                    .padding(.top, -50)
                    
                
                List {
                    ForEach(myWorkouts.workouts.sorted {$0.date < $1.date }) { workout in
                        WorkoutViewRow(workout: workout, formType: $formType)
                        .swipeActions {
                            Button(role: .destructive) {
                                myWorkouts.delete(workout)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .sheet(item: $formType) { $0 }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            formType = .new
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                        }
                    }
                }
            }
        }

    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
            .environmentObject(WorkoutStore(preview: true))
    }
}
