//
//  GetMeetSummaryView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct GetMeetSummaryView: View {
    
    @State var meets: [MeetDTO] = []
    @State var season = ""
    @State var seasons = ["Select Season"]
    @State var meetName = ""
    let resultsPerCategory = "50"
    @State private var viewSelection: String? = nil
    @State var meetSummaryResponse: MeetSummaryResponse?
    @State var prDisclosureGroupExpanded: Bool = false
    @State var sbDisclosureGroupExpanded: Bool = false
    @State var yearToYearDisclosureGroupExpanded: Bool = false
    @State var lastMeetDisclosureGroupExpanded: Bool = false
    @State var meetSplitsSummaryDisclosureGroupExpanded: Bool = false
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
                Background().edgesIgnoringSafeArea(.all).onAppear{
                    self.fetchMeetNames()
                }
                ScrollView {
                    VStack {
                    
                    Text("Meet Summaries")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                    

                    SeasonAndMeetPickerView(season: $season, seasons: $seasons, meets: $meets, meetName: $meetName)
                    
                    Button("Calculate") {
                        dataService.fetchMeetSumary(meetName: meetName, year: season, resultsPerCategory: resultsPerCategory) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let meetSummary):
                                    meetSummaryResponse = meetSummary
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                        }
                        
                    }.onTapGesture {
                        hideKeyboard()
                    }
                    .padding(.vertical).frame(width: 100.0, height: 75.0)
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.title2)
                
                    NavigationLink(destination: MeetSplitSummaryView(meetSplitStats: meetSummaryResponse?.meetSplitsSummaryResponse.meetSplitsStats), tag: "MeetSplitsSummary", selection: $viewSelection) { EmptyView() }
                        .onTapGesture {
                            hideKeyboard()
                        }
                    
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            DisclosureGroup(isExpanded: $prDisclosureGroupExpanded) {
                                 MeetSummaryPRsView(prsCount: meetSummaryResponse?.prs ?? PRsCount(count: 0, PRs: []))
                                } label: {
                                    Text("PRs")
                                    .onTapGesture {
                                    withAnimation {
                                        self.prDisclosureGroupExpanded.toggle()
                                    }
                                }
                            }
                                .background(.thinMaterial)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                                .font(.title2)
                            
                            DisclosureGroup(isExpanded: $sbDisclosureGroupExpanded) {
                                
                                MeetSummarySBsView(sbsCount: meetSummaryResponse?.seasonBests ?? SBsCount(count: 0, seasonBests: []))
                                
                            } label: {
                                Text("SBs")
                                .onTapGesture {
                                withAnimation {
                                    self.sbDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                            }.background(.thinMaterial)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                                .font(.title2)
                           
                        
                            DisclosureGroup(isExpanded: $yearToYearDisclosureGroupExpanded) {
                                
                                MeetSummaryYearToYearProgressionView(progressionData: meetSummaryResponse?.comparisonFromLastYear)
                                
                            } label: {
                                Text("Compare to last year")
                                .onTapGesture {
                                withAnimation {
                                    self.yearToYearDisclosureGroupExpanded.toggle()
                                }
                            }
                            }.background(.thinMaterial)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                                .font(.title2)
                            
                            DisclosureGroup(isExpanded: $lastMeetDisclosureGroupExpanded) {
                                
                                GetImprovementFromLastMeetView(comparisonLastMeet: meetSummaryResponse?.comparisonLastMeet)
                                
                            } label: {
                                Text("Compare to previous meet")
                                .onTapGesture {
                                withAnimation {
                                    self.lastMeetDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                            }.background(.thinMaterial)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                                .font(.title2)
                            
                            DisclosureGroup(isExpanded: $meetSplitsSummaryDisclosureGroupExpanded) {
                                
                                MeetSplitSummaryView(meetSplitStats: meetSummaryResponse?.meetSplitsSummaryResponse.meetSplitsStats)
                                
                            } label: {
                                Text("Show Meet Splits Summary")
                                .onTapGesture {
                                withAnimation {
                                    self.meetSplitsSummaryDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                            }.background(.thinMaterial)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}

//struct GetMeetSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetMeetSummaryView()
//    }
// }
