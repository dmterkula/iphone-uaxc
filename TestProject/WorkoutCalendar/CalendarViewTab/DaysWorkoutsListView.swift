//
//  DaysWorkoutsListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct DaysWorkoutsListView: View {
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @Binding var dateSelected: DateComponents?
    @State private var formType: WorkoutFormType?
    
    
    var body: some View {
        NavigationStack {
            Group {
                if let dateSelected {
                    let foundWorkouts = workoutStore.workouts.filter {
                        $0.date.startOfDay == dateSelected.date!.startOfDay
                    }
                    
                    List {
                        ForEach(foundWorkouts) { workout in
                            WorkoutViewRow(workout: workout, formType: $formType)
                                .swipeActions {
                                    Button(role: . destructive) {
                                        workoutStore.delete(workout)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                .sheet(item: $formType) { $0 }
                        }
                    }
                    
                }
            }
        }.navigationTitle(dateSelected?.date?.formatted(date: .long, time: .omitted) ?? "")
    }
}

struct DaysWorkoutsListView_Previews: PreviewProvider {
    
    static var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    static var previews: some View {
        DaysWorkoutsListView(dateSelected: .constant(dateComponents))
            .environmentObject(WorkoutStore(preview: true))
    }
}
