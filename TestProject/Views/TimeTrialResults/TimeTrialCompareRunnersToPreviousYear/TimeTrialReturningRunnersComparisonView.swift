//
//  TimeTrialReturningRunnersComparisonView.swift
//  UAXC
//
//  Created by David  Terkula on 9/8/22.
//

import SwiftUI

struct TimeTrialReturningRunnersComparisonView: View {
    
    @State var seasons: [String] = []
    @State var season: String = ""
    @State var bars: [Bar] = []
    @State var comparisonDTOs: [RunnerTimeTrialComparisonToPreviousYearDTO] = []
    
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
                self.fetchSeasons()
            }
            
            GeometryReader { geometry in
               ScrollView {
                    
                   VStack {
                        Text("Compare Time Trial Results")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding(.leading, 30)
                        
                        HStack {
                            SeasonPickerView(seasons: $seasons, season: $season)
                        }
                        
                        
                        if (!season.isEmpty) {
                            Button("Calculate") {
                               
                                dataService.fetchTimeTrialComparisonsForRunners(season: season) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            comparisonDTOs = response
                                            
                                            
                                            let fasterCount: Int = comparisonDTOs.filter { $0.timeDifference.contains("-")}.count
                                            let slowerCount: Int = comparisonDTOs.count - fasterCount
                                            
                                            let fasterBar = Bar(label: "Faster", value: Double(fasterCount), size: 1.0, scaleFactor: 1.0, color: .green)
                                            let slowerBar = Bar(label: "Slower", value: Double(slowerCount), size: 1.0, scaleFactor: 1.0, color: .red)
                                            
                                            bars = [fasterBar, slowerBar]
                                            
                                            case .failure(let error):
                                                print(error)
                                        }
                                    }
                                    
                                }
                                
                            }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                .font(.title2)
                        }
                        
                        
                        if (!comparisonDTOs.isEmpty) {
                            
                            BarChartView(bars: $bars, height: geometry.size.height / 3, width: geometry.size.width / 5)
                                .padding()
                            
                            TimeTrialResultComparedToPreviousYearView(comparisonDTOs: $comparisonDTOs, minHeight: geometry.size.height / 1.67)
                        } else {
                            Spacer().frame(minHeight: 20, maxHeight: 450)
                        }
                        
                    } // end vstack
                   
               }
                // This centers the content in the scroll view
               .frame(width: geometry.size.width)      // Make the scroll view full-width
               .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent// end scroll
                
            } // end geometry

        }
    }
}

//struct TimeTrialReturningRunnersComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialReturningRunnersComparisonView()
//    }
//}
