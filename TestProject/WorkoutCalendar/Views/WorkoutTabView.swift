//
//  WorkoutTabView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutTabView: View {
    @EnvironmentObject var myEvents: WorkoutStore
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        TabView{
            WorkoutListView()
                .tabItem {
                    Label("List", systemImage: "list.triangle")
                }
                .environmentObject(authentication)
                
            WorkoutCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .environmentObject(authentication)
                    
        }
        .environment(\.colorScheme, .light)
    }
}

struct WorkoutTabView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutTabView()
            .environmentObject(WorkoutStore(preview: true))
    }
}

