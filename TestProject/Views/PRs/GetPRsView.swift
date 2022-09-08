//
//  GetPRsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetPRsView: View {
    
    @State var prList: [Performance] = []
    @State var filter = ""
    @State var seasons: [String] = []
    @State var season: String = ""
    
    let dataService = DataService()
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear {
                fetchSeasons()
            }
            VStack {
                Text("UAXC PRs")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                HStack {
                    SeasonPickerView(seasons: $seasons, season: $season, label: "First Included Season: ")
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
                
                HStack {
                    Text("Filter by name: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    TextField("Maria", text: $filter)
                        .placeholder(when: $filter.wrappedValue.isEmpty) {
                                Text("Maria").foregroundColor(.white)
                        }
                        .opacity(0.75)
                        .keyboardType(.default)
                        .foregroundColor(.white)
                }
                
                Spacer().frame(minHeight: 20, maxHeight: 30)
                
                if (!season.isEmpty) {
                    Button("Get PRs") {
                       
                        let dataService = DataService()
                        let firstIncludedGradClass = String(Int(season)! + 1)
                        dataService.fetchPRs(lastIncludedGradClass: firstIncludedGradClass) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let prDTO):
                                    prList = prDTO.PRs
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                            
                        }
                        
                    }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.title2)
                }
                
             
                
                if (!prList.isEmpty) {
                    PerformanceList(performances: prList, filter: $filter)
                } else {
                    Spacer().frame(minHeight: 20, maxHeight: 450)
                }
                
            }
        }

    }
}

