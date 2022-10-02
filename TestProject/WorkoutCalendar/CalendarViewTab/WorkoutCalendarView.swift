//
//  WorkoutCalendarView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutCalendarView: View {
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @State private var dateSelected: DateComponents?
    @State private var displayWorkouts = false
    @State private var formType: WorkoutFormType?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture),
                             workoutStore: workoutStore,
                             dateSelected: $dateSelected,
                             displayWorkouts: $displayWorkouts)
                    .navigationTitle("Calendar View")
                
            }
            
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
            
            .sheet(item: $formType) { $0 }
            .sheet(isPresented: $displayWorkouts) {
                NavigationStack {
                    DaysWorkoutsListView(dateSelected: $dateSelected)
                        .presentationDetents([.medium, .large])
                }
                .environment(\.colorScheme, .light)
            }
        }
    }
}

struct WorkoutCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCalendarView()
            .environmentObject(WorkoutStore(preview: true))
    }
}
