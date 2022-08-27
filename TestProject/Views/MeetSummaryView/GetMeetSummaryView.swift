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
    @State var meetSummaryResponse: MeetSummaryResponse?
    
    
    var body: some View {
            VStack {
                Text("Meet Summary")
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
                
                HStack {
                    Text("Meet Name: ")
                    TextField("Moeller", text: $meetName)
                        .keyboardType(.alphabet)
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Season: ")
                    TextField("2021", text: $season)
                        .keyboardType(.default)
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Results Per Category: ")
                    TextField("50", text: $resultsPerCategory)
                        .keyboardType(.numberPad)
                }
                .padding(.top, 20)
                
                Button("Get Meet Summary") {
                   
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
                    
                }
                
                MeetSummaryPRsView(prsCount: meetSummaryResponse?.prs ?? PRsCount(count: 0, PRs: []))
                
            }
}

//struct GetMeetSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetMeetSummaryView()
//    }
}
