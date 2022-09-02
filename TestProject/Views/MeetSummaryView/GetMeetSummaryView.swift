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
    @State var prDisclosureGroupExpanded: Bool = false
    @State var sbDisclosureGroupExpanded: Bool = false
    @State var yearToYearDisclosureGroupExpanded: Bool = false
    @State var lastMeetDisclosureGroupExpanded: Bool = false
    @State var meetSplitsSummaryDisclosureGroupExpanded: Bool = false
    
    var body: some View {
            ZStack {
                Background().edgesIgnoringSafeArea(.all)
                ScrollView {
                VStack {
                    
                    Text("Meet Summaries")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                    
                    Group {
                        HStack {
                            Text("Meet Name: ")
                                .foregroundColor(.white)
                            TextField("Moeller", text: $meetName)
                                .keyboardType(.alphabet)
                                .foregroundColor(.white)
                                .placeholder(when: $meetName.wrappedValue.isEmpty) {
                                        Text("Moeller").foregroundColor(.white)
                                }
                                .opacity(0.75)
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
                                .opacity(0.75)
                        }
                        .padding(.top, 20)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                        HStack {
                            Text("Results Per Category: ")
                                .foregroundColor(.white)
                            TextField("50", text: $resultsPerCategory)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .placeholder(when: $resultsPerCategory.wrappedValue.isEmpty) {
                                        Text("50").foregroundColor(.white)
                                }
                                .opacity(0.75)
                        }
                        .padding(.top, 20)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                    }
                    
                    Button("Calculate") {
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
                        VStack(alignment: .leading, spacing: 0) {
//                            Button("Show PRs") {
//                                viewSelection = "PRs"
//                            }.foregroundColor(.white)
                            
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
                            .background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                            
                            DisclosureGroup(isExpanded: $sbDisclosureGroupExpanded) {
                                
                                MeetSummarySBsView(sbsCount: meetSummaryResponse?.seasonBests ?? SBsCount(count: 0, seasonBests: []))
                                
                            } label: {
                                Text("SBs")
                                .onTapGesture {
                                withAnimation {
                                    self.sbDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                        }.background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                           
                        
                            DisclosureGroup(isExpanded: $yearToYearDisclosureGroupExpanded) {
                                
                                MeetSummaryYearToYearProgressionView(progressionData: meetSummaryResponse?.comparisonFromLastYear)
                                
                            } label: {
                                Text("Compare to last year")
                                .onTapGesture {
                                withAnimation {
                                    self.yearToYearDisclosureGroupExpanded.toggle()
                                }
                            }
                        }.background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                            
                            DisclosureGroup(isExpanded: $lastMeetDisclosureGroupExpanded) {
                                
                                GetImprovementFromLastMeetView(comparisonLastMeet: meetSummaryResponse?.comparisonLastMeet)
                                
                            } label: {
                                Text("Compare to previous meet")
                                .onTapGesture {
                                withAnimation {
                                    self.lastMeetDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                        }.background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
                            
                            DisclosureGroup(isExpanded: $meetSplitsSummaryDisclosureGroupExpanded) {
                                
                                MeetSplitSummaryView(meetSplitStats: meetSummaryResponse?.meetSplitsSummaryResponse.meetSplitsStats)
                                
                            } label: {
                                Text("Show Meet Splits Summary")
                                .onTapGesture {
                                withAnimation {
                                    self.meetSplitsSummaryDisclosureGroupExpanded.toggle()
                                }
                            
                            }
                        }.background(Color(red: 107/255, green: 107/255, blue: 107/255))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .accentColor(.white)
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
