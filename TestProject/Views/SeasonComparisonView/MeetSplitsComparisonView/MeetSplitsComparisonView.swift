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
    @State var meetsDisclosureGroupDict: [String: Binding<Bool>] = [:]
    
    
    @State var meet1Bool = false
    @State var meet2Bool = false
    @State var meet3Bool = false
    @State var meet4Bool = false
    @State var meet5Bool = false
    @State var meet6Bool = false
    @State var meet7Bool = false
    @State var meet8Bool = false
    @State var meet9Bool = false
    @State var meet10Bool = false
    @State var bindingBools: [Binding<Bool>] = []
    
    
    
    // each meet has milesplits and each ile splits has bars
    
    
    let dataService = DataService()
    
    func fetchSeasons() {
        bindingBools =  [$meet1Bool, $meet2Bool, $meet3Bool, $meet4Bool, $meet5Bool, $meet6Bool, $meet7Bool, $meet8Bool, $meet9Bool, $meet10Bool]
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
                        
            var i = 0
            for tTestDTO in tTestDTOs {
                
                let meetName = tTestDTO.distributionSummaryComparisonYear[0].label.components(separatedBy: " ")[0]
                meetsDisclosureGroupDict[meetName] = bindingBools[i]
                i = i + 1
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
                            
                            ForEach($meetSplitBarComparisons) { meetSplitBarComparison in
                                
                                let meetName: String = meetSplitBarComparison.meetName.wrappedValue
                                
                                DisclosureGroup(isExpanded: self.meetsDisclosureGroupDict[meetName]!) {
                                    MeetSplitsComparisonChart(meetSplitBarComparison: meetSplitBarComparison, geometry: geometry).background(.thinMaterial)
                                
                                } label: {
                                    Text(meetName)
                                    .onTapGesture {
                                        withAnimation {
                                            self.meetsDisclosureGroupDict[meetName]!.wrappedValue.toggle()
                                            }
                                        }
                                    }
                                .accentColor(.white)
                                .font(.title3)
                                .padding(.all)
                                .background(.thinMaterial)
                                .cornerRadius(8)
                                .padding(.top, 10)
                               
                                
                            }.padding(.bottom, 10)
                            
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





