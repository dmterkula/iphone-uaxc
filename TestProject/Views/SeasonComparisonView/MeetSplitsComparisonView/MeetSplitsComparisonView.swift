//
//  MeetSplitsComparisonView.swift
//  UAXC
//
//  Created by David  Terkula on 9/10/22.
//

import SwiftUI

struct MeetSplitsComparisonView: View {
    
    @State var seasons: [String] = ["Select Season"]
    @State var baseSeason: String = ""
    @State var comparisonSeason: String = ""
    @State var tTestDTOs: [TTestDTO] = []
    @State var meetSplitBarComparisons: [MeetSplitBarComparison] = []
    
    // each meet has milesplits and each ile splits has bars
    
    
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
    
    func initialzeBars() {
        if(!tTestDTOs.isEmpty) {
                        
            for tTestDTO in tTestDTOs {
                
                let meetName = tTestDTO.distributionSummaryComparisonYear[0].label.components(separatedBy: " ")[0]
                var barComparisons: [BarComparison] = []
                
                for i in 0..<(tTestDTO.distributionSummaryComparisonYear.count) {
                    let mile1Percentile10BaseYear = tTestDTO.distributionSummaryBaseYear[i].percentile10
                    let mile1Percentile10ComparisonYear = tTestDTO.distributionSummaryComparisonYear[i].percentile10
                    
                    let mile1Percentile25BaseYear = tTestDTO.distributionSummaryBaseYear[i].percentile25
                    let mile1Percentile25ComparisonYear = tTestDTO.distributionSummaryComparisonYear[i].percentile25
                    
                    let mile1AvgBaseYear = tTestDTO.distributionSummaryBaseYear[i].meanDifference
                    let mile1AvgComparisonYear = tTestDTO.distributionSummaryComparisonYear[i].meanDifference
                    
                    let mile1Percentile75BaseYear = tTestDTO.distributionSummaryBaseYear[i].percentile75
                    let mile1Percentile75ComparisonYear = tTestDTO.distributionSummaryComparisonYear[i].percentile75
                    
                    let mile1Percentile90BaseYear = tTestDTO.distributionSummaryBaseYear[i].percentile90
                    let mile1Percentile90ComparisonYear = tTestDTO.distributionSummaryComparisonYear[i].percentile90
                    
                    let barsDataSet1 = [
                        Bar(label: "Top 10% " + baseSeason, value: (Double(mile1Percentile10BaseYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .green),
                        Bar(label: "Top 25% " + baseSeason, value: (Double(mile1Percentile25BaseYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .green),
                        Bar(label: "Avg. " + baseSeason, value: (Double(mile1AvgBaseYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .green),
                        Bar(label: "Bottom 25% " + baseSeason, value: (Double(mile1Percentile75BaseYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .green),
                        Bar(label: "Bottom 10% " + baseSeason, value: (Double(mile1Percentile90BaseYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .green),
                        
                    ]
                    let barsDataSet2 = [
                        Bar(label: "Top 10% " + comparisonSeason, value: (Double(mile1Percentile10ComparisonYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .yellow),
                        Bar(label: "Top 25% " + comparisonSeason, value: (Double(mile1Percentile25ComparisonYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .yellow),
                        Bar(label: "Avg. " + comparisonSeason, value: (Double(mile1AvgComparisonYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .yellow),
                        Bar(label: "Bottom 25% " + comparisonSeason, value: (Double(mile1Percentile75ComparisonYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .yellow),
                        Bar(label: "Bottom 10% " + comparisonSeason, value: (Double(mile1Percentile90ComparisonYear) ?? 0.0) * 100, size: 1.0, scaleFactor: 1.0, color: .yellow),
                        
                    ]
                    
                    barComparisons.append(BarComparison(barsDataSet1: barsDataSet1, dataSet1LegendLabel: baseSeason, barsDataSet2: barsDataSet2, dataSet2LegendLabel: comparisonSeason, comparisonLabels: ["Top 10 %", "Top 25%", "Avg.", "Bottom 25%", "Bottom 10%"]))
                }
                
                meetSplitBarComparisons.append(MeetSplitBarComparison(meetName: meetName, mile1BarComparison: barComparisons[0], mile2BarComparison: barComparisons[1], mile3BarComparison: barComparisons[2], tTestResults: tTestDTO.tTestResults))
                
            }
            
        }
    }
    
    func createPValueInterpretation(tTestResult: TTestResult) -> String {
        
        let percent = (tTestResult.pvalue * 100).rounded(toPlaces: 2)
        return "There is a " + String(percent) + " percent chance that the differnce in Avg. splits times compared to PR pace is due to chance/expected variation"
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear {
                self.fetchSeasons()
            }
            
            GeometryReader { geometry in
               ScrollView {
            
                    VStack {
                        Text("Meet Splits Comparison")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            SeasonPickerView(seasons: $seasons, season: $baseSeason, label: "Base Season: ")
                        }
                        .padding(.top, 20)
                        
                        if (!baseSeason.isEmpty) {
                            HStack {
                                SeasonPickerView(seasons: $seasons, season: $comparisonSeason, label: "Comparison Season: ")
                            }
                            .padding(.top, 20)
                        }
                        
                        if (!baseSeason.isEmpty && !comparisonSeason.isEmpty) {
                            Button("Calculate") {
                               
                                meetSplitBarComparisons = []
                                dataService.fetchMeetSplitsTTestForAllMeetsInSeasons(baseSeason: baseSeason, comparisonSeason: comparisonSeason, comparisonPace: "PR") { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            tTestDTOs = response
                                            initialzeBars()
                                            case .failure(let error):
                                                print(error)
                                        }
                                    }
                                    
                                }
                                
                            }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                .font(.title2)
                                .padding(.bottom, 40)
                                .padding(.top, 40)
                        }
                        
                        if (!meetSplitBarComparisons.isEmpty) {
                            
                            ForEach(meetSplitBarComparisons) { meetSplitBarComparison in
                                
                                VStack(spacing: 20) {
                                    
                                    Text(meetSplitBarComparison.meetName + " Splits Comparisons").font(.title2)
                                    
                                    let mile1ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[0])
                                    let mile2ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[1])
                                    let mile3ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[2])
                                    
                                    SideBySideBarChart(barComparison: meetSplitBarComparison.mile1BarComparison, title: "Mile 1 Pace as a Percent of PR Pace", descriptor: mile1ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.5 * Double(meetSplitBarComparison.mile1BarComparison.barsDataSet1.count))))
                                    
                                    SideBySideBarChart(barComparison: meetSplitBarComparison.mile2BarComparison, title: "Mile 2 Pace as a percent of PR Pace", descriptor: mile2ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.5 * Double(meetSplitBarComparison.mile2BarComparison.barsDataSet1.count))))
                                    
                                    SideBySideBarChart(barComparison: meetSplitBarComparison.mile3BarComparison, title: "Mile 3 Pace as a Percent of PR Pace", descriptor: mile3ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.5 * Double(meetSplitBarComparison.mile3BarComparison.barsDataSet1.count))))
                                    
                                }.background(.thinMaterial)
                                
                            }.padding(.bottom, 40)
                            
                        }
                      
                    } // end vstack
                   
               } // end scroll
                
            } // end geometry
            
        } // end zstack
    }
}

//struct MeetSplitsComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSplitsComparisonView()
//    }
//}





