//
//  AggregateStatsView.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import SwiftUI

struct AggregateStatsView: View {
    
    @State
    var isLoading = false
    @Binding
    var aggregateStatsResponse: AggregateStatsResponse?
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        if (aggregateStatsResponse == nil) {
           ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(3)
                .onAppear{ getAggregateStats() }
        } else {
  
            let stats = [
                Statistic(label: "Total runners tracked", value: String(aggregateStatsResponse!.totalRunners)),
                Statistic(label: "Total 5ks run", value: String(aggregateStatsResponse!.total5Ks)),
                Statistic(label: "Total miles raced", value: String(Double(aggregateStatsResponse!.total5Ks) * 3.1)),
                Statistic(label: "Total splits taken", value: String(aggregateStatsResponse!.totalSplits)),
                Statistic(label: "Total PRs achieved", value: String(aggregateStatsResponse!.aggregatePRStats.totalPRs)),
                Statistic(label: "Total time improved", value: String(aggregateStatsResponse!.aggregatePRStats.totalTimeImproved))
            ]
            
            VStack {
                Text ("Some aggregate stats over the years")
                    .font(.title2)
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                
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
                .background(.thinMaterial)
                .scaleEffect(0.90)
                //.listStyle(GroupedListStyle())
            }
        }
    }
    
    func getAggregateStats() {
        isLoading = true
        let dataService = DataService()
        dataService.fetchAggregateStats() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let stats):
                    aggregateStatsResponse = stats
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    
}
