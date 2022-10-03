//
//  WorkoutCalendarView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutCalendarView: View {
    
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var authentication: Authentication
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
                .environmentObject(authentication)
                .navigationTitle("Calendar View")
                
            }
            
            .toolbar {
                
                if (authentication.user != nil && authentication.user!.role == "coach") {
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
            
            .sheet(item: $formType) { $0 }
            .sheet(isPresented: $displayWorkouts) {
                NavigationStack {
                    DaysWorkoutsListView(dateSelected: $dateSelected)
                        .environmentObject(authentication)
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
