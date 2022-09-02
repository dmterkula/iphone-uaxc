//
//  GetHistoricalMeetComparisonView.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import SwiftUI

struct GetHistoricalMeetComparisonView: View {
    
    @State
    var targetMeet: String = ""
    @State
    var comparisonMeet: String = ""
    
    @State
    var historicalComparisonResponse: HistoricalMeetComparisonResponse? = nil
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5) {
                Text("Meet Comparisons")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            
                
                Text("Compare meet results taking runners' times from the target meet and subtracting their times from the meet to compare to")
                    .foregroundColor(Color.white)
                    .padding(.top, 10)
                
                
                HStack {
                    Text("Target Meet: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    TextField("Lebanon", text: $targetMeet)
                        .keyboardType(.default)
                        .foregroundColor(.white)
                        .placeholder(when: $targetMeet.wrappedValue.isEmpty) {
                                Text("Lebanon").foregroundColor(.white)
                        }
                        .opacity(0.75)
                }
                .padding(.top, 15)
                .onTapGesture {
                    hideKeyboard()
                }
                
                HStack {
                    Text("Meet to compare to: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    TextField("Moeller", text: $comparisonMeet)
                        .keyboardType(.default)
                        .foregroundColor(.white)
                        .placeholder(when: $comparisonMeet.wrappedValue.isEmpty) {
                                Text("Moeller").foregroundColor(.white)
                        }
                        .opacity(0.75)
                }
                .padding(.top, 15)
                .onTapGesture {
                    hideKeyboard()
                }.padding(.top, 15)
                
                
                Button("Compare Meets") {
                   
                    let dataService = DataService()
                    dataService.fetchHistoricalMeetComparison(baseMeet: comparisonMeet, comparisonMeet: targetMeet) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                historicalComparisonResponse = response
                                case .failure(let error):
                                    print(error)
                            }
                        }
                        
                    }
                    
                }
                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                .font(.title2)
                .padding(.top, 30)
                
                
                if (historicalComparisonResponse != nil) {
                    
                    Text("Results").foregroundColor(.white)
                        .font(.title2)
                        .padding(.top, 30)
                    
                    let stats = [
                        Statistic(label: "Top 10%", value: historicalComparisonResponse!.top10Percent),
                        Statistic(label: "Top 25%", value: historicalComparisonResponse!.top25Percent),
                        Statistic(label: "Mean Difference (50%)", value: historicalComparisonResponse!.meanDifference),
                        Statistic(label: "Bottom 25%", value: historicalComparisonResponse!.bottom25Percent),
                        Statistic(label: "Bottom 10%", value: historicalComparisonResponse!.bottom10Percent),
                        Statistic(label: "Sample Size", value: String(historicalComparisonResponse!.sampleSize)),
                        Statistic(label: "Standard Deviation", value: String(historicalComparisonResponse!.standardDeviation)),
                    ]
                    
                    List {
                        ForEach(stats) { value in
                            VStack(alignment: .leading, spacing: 3) {
                                HStack {
                                    Text(value.label + ":")
                                    Text(value.value)
                                }
                            }
                        }
                    }
                    .scaleEffect(0.90)
                    .listStyle(GroupedListStyle())
                    
                }
                
                Spacer()
                
            }
            
        }
    }
}

//struct GetHistoricalMeetComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetHistoricalMeetComparisonView()
//    }
//}
