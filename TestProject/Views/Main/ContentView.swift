//
//  ContentView.swift
//  TestProject
//
//  Created by David  Terkula on 8/14/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            Text("UAXC Stats")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
                .padding()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Main Page")
                }
            
            GetPRsView()
            .padding(.leading, 20.0)
            .tabItem {
                Image(systemName: "2.circle.fill")
                Text("PRs")
            }
            
            GetMeetResultsView()
                .tabItem {
                    Image(systemName: "3.circle.fill")
                    Text("Meet Results")
                }
            
            GetMeetSplitsView()
                .tabItem {
                    Image(systemName: "4.circle.fill")
                    Text("Meet Splits")
                }
            
            Text("Fifth Tab")
                .tabItem {
                    Image(systemName: "5.circle.fill")
                    Text("5th Tab")
                }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}