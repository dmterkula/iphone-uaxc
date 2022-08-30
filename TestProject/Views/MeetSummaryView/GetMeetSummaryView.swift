//
//  GetMeetSummaryView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct GetMeetSummaryView: View {
    
    @State var season = ""
    @State var meetName = ""
    @State var resultsPerCategory = ""
    @State private var viewSelection: String? = nil
    @State var meetSummaryResponse: MeetSummaryResponse?
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Group {
                
                    HStack {
                        Text("Meet Name: ")
                        TextField("Moeller", text: $meetName)
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
                    
                    HStack {
                        Text("Results Per Category: ")
                        TextField("50", text: $resultsPerCategory)
                            .keyboardType(.numberPad)
                    }
                    .padding(.top, 20)
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                }
                
                Button("Crunch the numbers") {
                   
                    let dataService = DataService()
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
                    
                }.padding(.vertical).frame(width: 100.0, height: 75.0)
            
                
                NavigationLink(destination: MeetSummaryPRsView(prsCount: meetSummaryResponse?.prs ?? PRsCount(count: 0, PRs: [])), tag: "PRs", selection: $viewSelection) { EmptyView() }
                NavigationLink(destination: MeetSummarySBsView(sbsCount: meetSummaryResponse?.seasonBests ?? SBsCount(count: 0, seasonBests: [])), tag: "SBs", selection: $viewSelection) { EmptyView() }
                NavigationLink(destination: MeetSummaryYearToYearProgressionView(progressionData: meetSummaryResponse?.comparisonFromLastYear), tag: "YearToYearProgressions", selection: $viewSelection) { EmptyView() }
                NavigationLink(destination: MeetSplitSummaryView(meetSplitStats: meetSummaryResponse?.meetSplitsSummaryResponse.meetSplitsStats), tag: "MeetSplitsSummary", selection: $viewSelection) { EmptyView() }
                NavigationLink(destination: GetImprovementFromLastMeetView(comparisonLastMeet: meetSummaryResponse?.comparisonLastMeet), tag: "MeetToMeetImprovement", selection: $viewSelection) { EmptyView() }
                
                Group {
                    VStack(alignment: .leading, spacing: 10) {
                        Button("Show PRs") {
                            viewSelection = "PRs"
                        }

                        Button("Show SBs") {
                            viewSelection = "SBs"
                        }

                        Button("Comparison to last year") {
                            viewSelection = "YearToYearProgressions"
                        }
                        
                        Button("Compare to last meet") {
                            viewSelection = "MeetToMeetImprovement"
                        }
                        
                        Button("Show Meet Splits Summary") {
                            viewSelection = "MeetSplitsSummary"
                        }
                    }
                }
            }
            .navigationTitle("Meet Summary Page")
        }
}

//struct GetMeetSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetMeetSummaryView()
//    }
}
