//
//  WorkoutCalendarView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct EventCalendarView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var authentication: Authentication
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    @State private var formType: EventFormType?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture),
                             eventStore: eventStore,
                             dateSelected: $dateSelected,
                             displayEvents: $displayEvents)
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
            .sheet(isPresented: $displayEvents) {
                NavigationStack {
                    DaysEventsListView(dateSelected: $dateSelected)
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
        EventCalendarView()
            .environmentObject(EventStore(preview: true))
    }
}
