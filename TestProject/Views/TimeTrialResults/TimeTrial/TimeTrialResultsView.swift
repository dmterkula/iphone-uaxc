//
//  SwiftUIView.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import SwiftUI

struct TimeTrialResultsView: View{
    @State var season = ""
    @State var seasons: [String] = []
    @State var scaleTo5k = false
    @State var timeTrialResultsDTOs: [TimeTrialResultsDTO]?
    
    let dataService = DataService()
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons = Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear{
                self.fetchSeasons()
            }
            VStack {
                Text("Time Trial Results")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                VStack (alignment: .leading) {
                    HStack {
                        SeasonPickerView(seasons: $seasons, season: $season)
                    }.padding(.bottom, 15)
                    
                    Button(action: {
                        self.scaleTo5k.toggle()
                        },label: {
                            if (self.$scaleTo5k.wrappedValue == true) {
                                Text("Scale to 5k: True")
                            } else {
                                Text("Scale to 5k: False")
                            }
                        }).foregroundColor(.white)
                }
                
                
                Spacer().frame(minHeight: 20, maxHeight: 30)
                
                
                if (!season.isEmpty) {
                    Button("Get Results") {
                       
                        let dataService = DataService()
                        dataService.fetchTimeTrialResults(season: $season.wrappedValue, scaleTo5k: String($scaleTo5k.wrappedValue)) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    timeTrialResultsDTOs = response
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                        }
                        
                    }
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.title2)
                }

                
                if (timeTrialResultsDTOs != nil && !timeTrialResultsDTOs!.isEmpty) {
                    List {
                        ForEach(timeTrialResultsDTOs!) { result in
                            TimeTrialDTOView(timeTrialDTO: result)
                        }
                    }.onTapGesture {
                        hideKeyboard()
                    }
                } else {
                    Spacer()
                }
                
            }
        }

    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialResults()
//    }
//}
