//
//  WorkoutTabView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutTabView: View {
    @EnvironmentObject var myEvents: WorkoutStore
    var body: some View {
        TabView{
            WorkoutListView()
                .tabItem {
                    Label("List", systemImage: "list.triangle")
                }
                
            WorkoutCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                    
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

