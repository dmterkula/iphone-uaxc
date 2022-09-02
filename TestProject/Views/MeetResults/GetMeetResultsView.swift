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
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            VStack {
                Text("UAXC Meet Results")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                HStack {
                    Text("Meet Name: ")
                        .foregroundColor(.white)
                    TextField("Mason", text: $meetName)
                        .keyboardType(.alphabet)
                        .foregroundColor(.white)
                        .placeholder(when: $meetName.wrappedValue.isEmpty) {
                                Text("Mason").foregroundColor(.white)
                        }
                        .opacity(0.25)
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
                
                HStack {
                    Text("Season: ")
                        .foregroundColor(.white)
                    TextField("2021", text: $season)
                        .keyboardType(.default)
                        .foregroundColor(.white)
                        .placeholder(when: $season.wrappedValue.isEmpty) {
                                Text("2021").foregroundColor(.white)
                        }
                        .opacity(0.25)
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
            
                Spacer().frame(minHeight: 20, maxHeight: 30)
            
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
                    
                }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.title2)
                
                if (!performanceList.isEmpty) {
                    MeetPerformanceList(performances: performanceList)
                }
                
                Spacer().frame(minHeight: 20, maxHeight: 500)
               
            }
        }
        
    }
}
