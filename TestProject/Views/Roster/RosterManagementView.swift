//
//  RosterManagementView.swift
//  UAXC
//
//  Created by David  Terkula on 10/4/22.
//

import SwiftUI

struct RosterManagementView: View {
    
    let dataService = DataService()
    
    @State var runners: [Runner] = []
    @State var seasons: [String] = []
    @State var season: String = ""
    @State var getActiveRunners: Bool = true
    @State private var formType: RunnerFormType?
    @EnvironmentObject var runnerStore: RunnerStore
    @State var nameFilter: String = ""
    
    func initializeSeasons() {
        
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    
                    seasons += Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} }))
                    
                    seasons = seasons.sorted().reversed()
                    
                    season = seasons[0]

                    let nextYearString: String = String(Int(seasons[0])! + 1)
                    print(nextYearString)
                    seasons.append(nextYearString)
                    
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
       
        
    }
    
    func fetchRoster(givenSeason: String, getActiveOnly: Bool) {
        runnerStore.fetchRosterGivenYear(givenSeason: givenSeason, getActiveOnly: getActiveOnly)
    }
    
    func filterRosterByName(filterFor: String) -> [Runner] {
        if (filterFor.isEmpty) {
            return runnerStore.roster
        } else {
            return  runnerStore.roster.filter{$0.name.lowercased().contains(filterFor.lowercased())}
        }
    }
    
    var body: some View {
        
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear{
                self.initializeSeasons()
            }
            
            VStack {
                
                Text("Roster Management")
                    .font(.largeTitle)
                .sheet(item: $formType) { $0 }

                
                VStack {
                    HStack {
                        
                        Text("Select Season: ")
                            .font(.title3)
                        
                        if (!seasons.isEmpty) {
                            Picker("Season: ", selection: $season, content: {
                                ForEach(seasons, id: \.self, content: { seasonYear in
                                    Text(seasonYear).foregroundColor(.white)
                                        .font(.title3)
                                })
                            })
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(.white)
                            .labelsHidden()
                            .font(.title3)
                            .onChange(of: season) { newValue in
                                fetchRoster(givenSeason: newValue, getActiveOnly: getActiveRunners)
                            }
                        }
                        
                    }
                    
                    HStack {
                        Spacer()
                        Text("Filter by name: ")
                            .font(.title3)
                            .foregroundColor(.white)
                        TextField("Name", text: $nameFilter)
                            .foregroundColor(.white)
                            .fixedSize()
                        Spacer()
                    }
                
                    
                    HStack {
                        Spacer()
                        Toggle("Active member of team: ", isOn: $getActiveRunners)
                            .frame(width: 250)
                            .onChange(of: getActiveRunners) {newValue in
                                fetchRoster(givenSeason: season, getActiveOnly: newValue)
                            }
                        Spacer()
                    }
                    
                    
                }

                
//                Button("Get Roster") {
//                   fetchRoster(givenSeason: season, getActiveOnly: getActiveRunners)
//                }.onTapGesture {
//                    hideKeyboard()
//                }
//                .padding(.vertical).frame(width: 150.0, height: 75.0)
//                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
//                .font(.title2)
                
                if (!runnerStore.roster.isEmpty) {
                
                    HStack {
                        Spacer()
                        
                        Button {
                            formType = .new
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .renderingMode(.template)
                                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                .imageScale(.large)
                        }.padding(.trailing, 10)
                    }
                    
                    let rosterList: [Runner] = filterRosterByName(filterFor: nameFilter)
                    
                    List {
                        ForEach(rosterList) { runner in
                            HStack {
                                VStack(alignment: .leading) {
                                    /*@START_MENU_TOKEN@*/Text(runner.name)/*@END_MENU_TOKEN@*/
                                    Text((runner.graduatingClass))
                                }
                                
                                Spacer()
                                
                                Button {
                                    formType = .update(runner)
                                } label: {
                                    Text("Edit")
                                }
                                .buttonStyle(.bordered)
                                .padding(.trailing, 10)
                                
                            }
                           
                        }
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .refreshable {
                        runnerStore.fetchRosterGivenYear(givenSeason: season, getActiveOnly: getActiveRunners)
                    }
                    .sheet(item: $formType) { $0 }
                }


            }
            
            
        } // end z stack
        
    }
}

struct RosterManagementView_Previews: PreviewProvider {
    static var previews: some View {
        RosterManagementView()
    }
}
