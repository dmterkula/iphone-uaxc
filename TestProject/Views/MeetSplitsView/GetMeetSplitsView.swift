//
//  GetMeetSplitsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetMeetSplitsView: View {
    
    @State var season = ""
    @State var runnerName = ""
    @State var meetSplits: [MeetSplit] = []
    
    var body: some View {
        VStack {
            Text("UAXC Meet Splits")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
            HStack {
                Text("Runner Name: ")
                TextField("Joanie", text: $runnerName)
                    .keyboardType(.alphabet)
            }
            .padding(.top, 20)
            .onTapGesture {
                hideKeyboard()
            }
            
            HStack {
                Text("Season: ")
                TextField("2021", text: $season)
                    .keyboardType(.default)
            }
            .padding(.top, 20)
            .onTapGesture {
                hideKeyboard()
            }
            
            Spacer().frame(minHeight: 20, maxHeight: 30)
            
            Button("Get MeetSplits") {
               
                let dataService = DataService()
                dataService.fetchMeetSplitsForRunner(runnerName: runnerName, year: season) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let meetSplitsResponse):
                            meetSplits = meetSplitsResponse.splits
                            case .failure(let error):
                                print(error)
                        }
                    }
                    
                }
                
            }
            
            MeetSplitsList(meetSplits: meetSplits)
        }
    }
}

