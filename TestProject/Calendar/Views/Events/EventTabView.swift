//
//  WorkoutTabView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct EventTabView: View {
    @EnvironmentObject var myEvents: EventStore
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        TabView{
            EventListView()
                .tabItem {
                    Label("List", systemImage: "list.triangle")
                }
                .environmentObject(authentication)
                
            EventCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .environmentObject(authentication)
                    
        }
        .environment(\.colorScheme, .light)
    }
}

struct EventTabView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabView()
            .environmentObject(EventStore(preview: true))
    }
}

