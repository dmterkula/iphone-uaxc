//
//  MeetResultsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetMeetResultsView: View {
    
    @State var season = ""
    @State var meetName = ""
    @State var performanceList: [MeetPerformance] = []
    
    var body: some View {
        VStack {
            Text("UAXC Meet Results")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
            HStack {
                Text("Meet Name: ")
                TextField("Mason", text: $meetName)
                    .keyboardType(.alphabet)
            }
            .padding(.top, 20)
            
            HStack {
                Text("Season: ")
                TextField("2021", text: $season)
                    .keyboardType(.default)
            }
            .padding(.top, 20)
            
            MeetPerformanceList(performances: performanceList)
            
        
            Button("Get MeetResults") {
               
                let dataService = DataService()
                dataService.fetchMeetResults(meetName: meetName, year: season) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let meetResponseDTO):
                            performanceList = meetResponseDTO.performances
                            case .failure(let error):
                                print(error)
                        }
                    }
                    
                }
                
            }
            
            Spacer()
        }
    }
}
