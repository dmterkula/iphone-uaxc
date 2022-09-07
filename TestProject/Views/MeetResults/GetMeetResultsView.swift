//
//  MeetResultsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetMeetResultsView: View {
    
    @State var meets: [MeetDTO] = []
    @State var season = ""
    @State var seasons = ["Select Season"]
    @State var meetName = ""

    @State var performanceList: [MeetPerformance] = []
    
    let dataService = DataService()
    
    func fetchMeetNames() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    
                    meets = meetInfoResponse.meets
                    
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
                .onAppear {
                    self.fetchMeetNames()
                }
            VStack {
                Text("UAXC Meet Results")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                SeasonAndMeetPickerView(season: $season, seasons: $seasons, meets: $meets, meetName: $meetName)
                
                Spacer().frame(minHeight: 20, maxHeight: 50)
            
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
                } else {
                    Spacer().frame(minHeight: 20, maxHeight: 500)
                }
               
            }
        }
        
    }
}
