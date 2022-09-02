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
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            VStack {
                Text("UAXC Meet Splits")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                HStack {
                    Text("Runner Name: ")
                        .foregroundColor(.white)
                    TextField("Joanie", text: $runnerName)
                        .keyboardType(.alphabet)
                        .placeholder(when: $runnerName.wrappedValue.isEmpty) {
                                Text("Joanie").foregroundColor(.white)
                        }
                        .opacity(0.75)
                        .foregroundColor(.white)
                    
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
                
                HStack {
                    Text("Season: ")
                        .foregroundColor(.white)
                    TextField("2022", text: $season)
                        .keyboardType(.default)
                        .placeholder(when: $season.wrappedValue.isEmpty) {
                                Text("2022").foregroundColor(.white)
                        }
                        .opacity(0.75)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }.padding(.bottom, 15)
                
            
                
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
                    
                }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.title2)
                
                if (!meetSplits.isEmpty) {
                    MeetSplitsList(meetSplits: meetSplits)
                }
                
                Spacer().frame(minHeight: 20, maxHeight: 500)
                
            }
        }
    }
}

