//
//  ContentView.swift
//  TestProject
//
//  Created by David  Terkula on 8/14/22.
//

import SwiftUI


let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView: View {
    
    @StateObject var authentication = Authentication()
    @StateObject var appInfo = AppVersionChecker()
    
    var body: some View {
        if (authentication.isValdiated) {
            if (authentication.user?.role == "runner") {
                if (authentication.runnerProfile == nil) {
                    LoadingPageView(authentication: authentication)
                } else { // have profile, load it
                    RunnerBaseView()
                        .environmentObject(authentication)
                }
                
            } else {
                BaseView()
                    .environmentObject(authentication)
            }
        } else {
            LoginView()
                .environmentObject(authentication)
                .environmentObject(appInfo)
        }
        
        
    }
    
}

struct LoadingPageView: View {
    @ObservedObject var authentication: Authentication
    @State var showProgressView = true
    let dataService = DataService()
    
    let facts = ["fact 1", "fact 2", "fact 3"]
    
    var body: some View {
            
        ZStack {
            Background().edgesIgnoringSafeArea(.all).onAppear() {
                
                if (authentication.runner != nil) {
                    dataService.fetchRunnerProfileV2(runnerId: authentication.runner!.runnerId, season: GlobalFunctions.getRelevantYear()) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                authentication.runnerProfile = response
                                showProgressView = false
                            case .failure(let error):
                                print(error)
                                authentication.runnerProfile = nil
                            }
                        }
                    }
                }
                
            }
            
            VStack {
                Text("Loading your profile...")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 40)
                
                Image("lion-loading")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 450)
                    .padding(.bottom, 40)
                
                if (showProgressView) {
                    ProgressView()
                        .scaleEffect(3)
                        .padding(.bottom, 20)
                }
                    
                
                // todo
                
                // make the facts backend driven so you can change them without a release.
                
                // read from a table and itialize that way, or have your back-end service generate it
                
                // for even more fun, allow the coaches to manage the log in view messages
                
//                let randomInt = Int.random(in: 0..<facts.count)
//
//                Text(facts[randomInt])
//                    .foregroundColor(.white)
//                    .font(.title3)
                
            }
        }
        
    }
    
}

struct Background : View {
    
    static let color0 = Color(red: 0/255, green: 255/255, blue: 68/255);
            
    static let color1 = Color(red: 58/255, green: 63/255, blue: 63/255)

    static let color2 = Color(red: 217/255, green: 216/255, blue: 18/255);
            
    let gradient = Gradient(colors: [color0, color1, color2]);
    var body: some View {
        
        Rectangle()
        .fill(LinearGradient(
                                    gradient: gradient,
                                    startPoint: .top,
                                    endPoint: .bottom)
                                  )
    }
}


struct RunnerBaseView: View {
    
    @State var showMenu = false
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        
        let drag = DragGesture()
        .onEnded {
            if $0.translation.width < -100 {
                withAnimation {
                    self.showMenu = false
                }
            }
        }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    Background().edgesIgnoringSafeArea(.all)

                    RunnerProfileV2View(runner: authentication.runner, runnerProfileResponse: authentication.runnerProfile, trainingRunSummary: authentication.runnerProfile?.trainingRunSummary ?? [], season: GlobalFunctions.getRelevantYear())
                        .preferredColorScheme(.dark)
                        .environment(\.colorScheme, .light)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                        .environmentObject(authentication)
              
                    
                    if self.showMenu {
                        MainMenuView(showMenu: $showMenu)
                            .frame(width: geometry.size.width / 1.33)
                            .transition(.move(edge: .leading))
                            .environmentObject(authentication)
                    }
                }
                .gesture(drag)
                
            }.navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                ))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        authentication.runnerProfile = nil
                        authentication.updateValidation(success: AuthenticationResponse(authenticated: false))
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                }
            }
        }
    }
}


struct BaseView: View {
    
    @State var showMenu = false
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        
        let drag = DragGesture()
        .onEnded {
            if $0.translation.width < -100 {
                withAnimation {
                    self.showMenu = false
                }
            }
        }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    Background().edgesIgnoringSafeArea(.all)
                    
                    // todo profile for athletes with menu, or base view for coaches with menu
                    
                    if (authentication.user?.role == "coach") {
                        HomePageView(showMenu: self.$showMenu)
                            .preferredColorScheme(.dark)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false)
                            .environmentObject(authentication)
                    } else if (authentication.user?.role == "runner") {
                        HomePageView(showMenu: self.$showMenu)
                            .preferredColorScheme(.dark)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false)
                            .environmentObject(authentication)
                    }
                    
                    
                    if self.showMenu {
                        MainMenuView(showMenu: $showMenu)
                            .frame(width: geometry.size.width / 1.33)
                            .transition(.move(edge: .leading))
                            .environmentObject(authentication)
                    }
                }
                .gesture(drag)
                
            }.navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                ))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        authentication.updateValidation(success: AuthenticationResponse(authenticated: false))
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct HomePageView: View {
    
    @Binding var showMenu: Bool
    @State var aggregateStatsResponse: AggregateStatsResponse?
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        
        VStack {
            Text("UAXC Stats")
                .font(.system(size: 36, weight: .semibold))
                .foregroundColor(Color.white)
                .padding(.bottom, 50)
            
            AggregateStatsView(aggregateStatsResponse: $aggregateStatsResponse)
                .environmentObject(authentication)
            
            Spacer().frame(minHeight:50, maxHeight: 150)
        }
    }
}



struct MainMenuView: View {
    
    @StateObject var myEvents = EventStore(preview: false)
    @StateObject var roster = RunnerStore(preview: false)
    @Binding var showMenu: Bool
    @State var runnerDisclosureIsExpanded: Bool = false
    @State var goalsDisclosureGroupIsExpanded: Bool = false
    @State var calendarDisclosureGroupIsExpanded: Bool = false
    @State var meetDisclosureIsExpanded: Bool = false
    @State var timeTrialDisclosureIsExpanded: Bool = false
    @State var seasonComparisonDisclosureIsExpanded: Bool = false
    @State var rosterDisclosureGroupIsExpanded: Bool = false
    @State var leaderboardsDiscloureGroupIsExapnded: Bool = false
    
    @EnvironmentObject var authentication: Authentication
    
    @State private var viewSelection: String? = nil
    
    var body: some View {
            
        ScrollView {
            VStack(alignment: .leading) {
                
                DisclosureGroup(isExpanded: $calendarDisclosureGroupIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "View Calendar", image: "figure.run")
                            .padding(.top, 30)
                        
                        TabButton(title: "Training Summary", image: "chart.xyaxis.line")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Calendar and Training")
                    .onTapGesture {
                        withAnimation {
                            self.calendarDisclosureGroupIsExpanded.toggle()
                            }
                        }
                    }
                .accentColor(.white)
                .font(.title3)
                .padding(.all)
                .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                .cornerRadius(8)
                .padding(.top, 200)
                
                DisclosureGroup(isExpanded: $runnerDisclosureIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "PRs", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Meet Splits", image: "list.number")
                            .padding(.top, 30)
                        
                        TabButton(title: "Runner Profile", image: "person")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Runner Stats")
                    .onTapGesture {
                        withAnimation {
                            self.runnerDisclosureIsExpanded.toggle()
                            }
                        }
                    }
                .accentColor(.white)
                .font(.title3)
                .padding(.all)
                .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                .cornerRadius(8)
                .padding(.top)
                
                
                DisclosureGroup(isExpanded: $leaderboardsDiscloureGroupIsExapnded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "PR Leaders", image: "medal")
                            .padding(.top, 30)
                        
                        TabButton(title: "SB Leaders", image: "star")
                            .padding(.top, 30)
                        
                        TabButton(title: "Race Split Consistency", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Distance Run", image: "figure.run")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Leaderboard")
                    .onTapGesture {
                        withAnimation {
                            self.leaderboardsDiscloureGroupIsExapnded.toggle()
                            }
                        }
                    }
                .accentColor(.white)
                .font(.title3)
                .padding(.all)
                .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                .cornerRadius(8)
                .padding(.top)

                
                DisclosureGroup(isExpanded: $goalsDisclosureGroupIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "Goal Management", image: "pencil")
                            .padding(.top, 30)
                        
                        if (authentication.user != nil && authentication.user!.role == "coach") {
                            TabButton(title: "View All Goals", image: "book")
                                .padding(.top, 30)
                        }
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Goals")
                    .onTapGesture {
                        withAnimation {
                            self.goalsDisclosureGroupIsExpanded.toggle()
                            }
                        }
                    }
                .accentColor(.white)
                .font(.title3)
                .padding(.all)
                .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                .cornerRadius(8)
                .padding(.top)

            
                DisclosureGroup(isExpanded: $meetDisclosureIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "Meet Results", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Meet Summary", image: "book")
                            .padding(.top, 30)
                        
                        if (authentication.user != nil && authentication.user!.role == "coach") {
                            TabButton(title: "Historical Meet Comparisons", image: "gearshape.2")
                                .padding(.top, 30)
                        }
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Meet Stats")
                    .onTapGesture {
                        withAnimation {
                            self.meetDisclosureIsExpanded.toggle()
                            }
                        }
                    }
                .accentColor(.white)
                .font(.title3)
                .padding(.all)
                .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                .cornerRadius(8)
                .padding(.top)
                
                DisclosureGroup(isExpanded: $timeTrialDisclosureIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "Time Trial Results", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Time Trial Progression", image: "gearshape.2")
                            .padding(.top, 30)
                        
                        if (authentication.user != nil && authentication.user!.role == "coach") {
                            TabButton(title: "Compare Returning Runners To Last Year", image: "gearshape.2")
                                .padding(.top, 30)
                        }
                        
                        
                    }
                } label: {
                    Text("Time Trial Stats")
                    .onTapGesture {
                        withAnimation {
                            self.timeTrialDisclosureIsExpanded.toggle()
                            }
                        }
                    }.accentColor(.white)
                    .font(.title3)
                    .padding(.all)
                    .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                    .cornerRadius(8)
                    .padding(.top)
                
                
                if (authentication.user != nil && authentication.user!.role == "coach") {
                    DisclosureGroup(isExpanded: $rosterDisclosureGroupIsExpanded) {
                            
                        VStack(alignment: .leading) {
                            TabButton(title: "Roster", image: "person.3")
                                .padding(.top, 30)
                        }
                    } label: {
                        Text("Roster")
                        .onTapGesture {
                            withAnimation {
                                self.rosterDisclosureGroupIsExpanded.toggle()
                                }
                            }
                        }.accentColor(.white)
                        .font(.title3)
                        .padding(.all)
                        .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                        .cornerRadius(8)
                        .padding(.top)
                }
                
                if (authentication.user != nil && authentication.user!.role == "coach") {
                    DisclosureGroup(isExpanded: $seasonComparisonDisclosureIsExpanded) {
                            
                        VStack(alignment: .leading) {
                            TabButton(title: "Meet Splits Comparisons", image: "stopwatch")
                                .padding(.top, 30)
                        }
                    } label: {
                        Text("Season Comparison")
                        .onTapGesture {
                            withAnimation {
                                self.seasonComparisonDisclosureIsExpanded.toggle()
                                }
                            }
                        }.accentColor(.white)
                        .font(.title3)
                        .padding(.all)
                        .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                        .cornerRadius(8)
                        .padding(.top)
                }
                
                Spacer()
            }
            .padding(.all)
        
        }.frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .background(Color(red: 107/255, green: 107/255, blue: 107/255))
            .edgesIgnoringSafeArea(.all)
                        
        
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        NavigationLink {
            
            if (title == "PRs") {
                GetPRsView()
            } else if (title == "Meet Results") {
                GetMeetResultsView()
            } else if (title == "Meet Splits") {
                GetMeetSplitsView()
            } else if (title == "Meet Summary") {
                GetMeetSummaryView()
            } else if (title == "Runner Profile") {
                RunnerProfileV2View()
                    .environmentObject(authentication)
                    .environment(\.colorScheme, .light)
            } else if (title == "Historical Meet Comparisons") {
                GetHistoricalMeetComparisonView()
            }
            else if (title == "Time Trial Results") {
                TimeTrialResultsView()
            } else if (title == "Time Trial Progression") {
                TimeTrialToSBProgressionView()
            } else if(title == "Compare Returning Runners To Last Year") {
                TimeTrialReturningRunnersComparisonView()
            } else if (title == "Meet Splits Comparisons") {
                MeetSplitsComparisonView()
            } else if (title == "Goal Management") {
                RunnersGoalsViewV2()
                    .environmentObject(authentication)
            } else if (title == "View All Goals") {
                ViewAllGoals()
            } else if (title == "View Calendar") {
                EventTabView()
                    .environmentObject(myEvents)
            } else if (title == "Roster") {
                RosterManagementView()
                    .environmentObject(roster)
            } else if(title == "PR Leaders") {
                PRLeaderboardView()
            } else if(title == "SB Leaders") {
                SBLeaderboardView()
            } else if (title == "Race Split Consistency") {
                RaceSplitConsistencyLeaderboardView()
            } else if (title == "Distance Run") {
                TrainingDistanceRunLeaderboardView()
            } else if (title == "Training Summary") {
                TrainingSummaryView()
            }
            else {
                HomePageView(showMenu: $showMenu)
            }
    
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .imageScale(.large)
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }.accentColor(.white)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageView()
//    }
//}
