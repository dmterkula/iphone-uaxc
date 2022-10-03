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
    
    var body: some View {
        if (authentication.isValdiated) {
            BaseView()
                .environmentObject(authentication)
        } else {
            LoginView()
                .environmentObject(authentication)
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
                    HomePageView(showMenu: self.$showMenu)
                        .preferredColorScheme(.dark)
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
    
    @StateObject var myEvents = WorkoutStore(preview: false)
    @Binding var showMenu: Bool
    @State var runnerDisclosureIsExpanded: Bool = false
    @State var goalsDisclosureGroupIsExpanded: Bool = false
    @State var workoutsDisclosureGroupIsExpanded: Bool = false
    @State var meetDisclosureIsExpanded: Bool = false
    @State var timeTrialDisclosureIsExpanded: Bool = false
    @State var seasonComparisonDisclosureIsExpanded: Bool = false
    
    @EnvironmentObject var authentication: Authentication
    
    @State private var viewSelection: String? = nil
    
    var body: some View {
            
        ScrollView {
            VStack(alignment: .leading) {
                
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
                .padding(.top, 200)
                
                
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
                
                DisclosureGroup(isExpanded: $workoutsDisclosureGroupIsExpanded) {
                        
                    VStack(alignment: .leading) {
                        TabButton(title: "View Workouts", image: "figure.run")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                } label: {
                    Text("Workouts")
                    .onTapGesture {
                        withAnimation {
                            self.workoutsDisclosureGroupIsExpanded.toggle()
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
                GetRunnerProfileView()
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
                RunnersGoalsView()
                    .environmentObject(authentication)
            } else if (title == "View All Goals") {
                ViewAllGoals()
            } else if (title == "View Workouts") {
                WorkoutTabView()
                    .environmentObject(myEvents)
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
