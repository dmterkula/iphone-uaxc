//
//  ContentView.swift
//  TestProject
//
//  Created by David  Terkula on 8/14/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        BaseView()
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
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MainMenuView(showMenu: $showMenu)
                            .frame(width: geometry.size.width / 1.33)
                            .transition(.move(edge: .leading))
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
        }
//        TabView {
//
//            Text("UAXC Stats")
//                .font(.largeTitle)
//                .foregroundColor(Color.blue)
//                .padding()
//                .tabItem {
//                    Image(systemName: "1.circle.fill")
//                    Text("Main Page")
//                }
//
//            GetPRsView()
//            .padding(.leading, 20.0)
//            .tabItem {
//                Image(systemName: "2.circle.fill")
//                Text("PRs")
//            }
//
//            GetMeetResultsView()
//                .tabItem {
//                    Image(systemName: "3.circle.fill")
//                    Text("Meet Results")
//                }
//
//            GetMeetSplitsView()
//                .tabItem {
//                    Image(systemName: "4.circle.fill")
//                    Text("Meet Splits")
//                }
//
//            GetMeetSummaryView()
//                .tabItem {
//                    Image(systemName: "5.circle.fill")
//                    Text("Meet Summary")
//                }
//        }
    }
}

struct HomePageView: View {
    
    @Binding var showMenu: Bool
    var body: some View {
        
        VStack {
            Text("UAXC Stats")
                .font(.largeTitle)
                .foregroundColor(Color.white)
            
            
            Spacer().frame(minHeight:100, maxHeight: 600)
        }
    }
}

struct MainMenuView: View {
    
    @Binding var showMenu: Bool
    @State var runnerDisclosureIsExpanded: Bool = false
    @State var meetDisclosureIsExpanded: Bool = false
    @State private var viewSelection: String? = nil
    
    var body: some View {
            
        ScrollView {
            VStack(alignment: .leading) {
                
    //            TabButton(title: "PRs", image: "person")
    //                .padding(.top, 120)
    //
    //            TabButton(title: "Meet Results", image: "person.3")
    //                .padding(.top, 30)
    //
    //
    //
    //
    //            TabButton(title: "Meet Summary", image: "book")
    //                .padding(.top, 30)
    //
    //            TabButton(title: "Home", image: "house")
    //                .padding(.top, 30)
                    
                    
                DisclosureGroup("Runner Stats", isExpanded: $runnerDisclosureIsExpanded) {
                        
                    VStack {
                        TabButton(title: "PRs", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Meet Splits", image: "list.number")
                            .padding(.top, 30)
                        
                        TabButton(title: "Runner Profile", image: "person")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                }.accentColor(.white)
                    .font(.title3)
                    .padding(.all)
                    .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                    .cornerRadius(8)
                    .padding(.top, 200)
                
                DisclosureGroup("Meet Stats", isExpanded: $meetDisclosureIsExpanded) {
                        
                    VStack {
                        TabButton(title: "Meet Results", image: "stopwatch")
                            .padding(.top, 30)
                        
                        TabButton(title: "Meet Summary", image: "book")
                            .padding(.top, 30)
                        
                        Spacer()
                        
                    }
                }.accentColor(.white)
                    .font(.title3)
                    .padding(.all)
                    .background(Color(red: 4/255, green: 130/255, blue: 0/255))
                    .cornerRadius(8)
                    .padding(.top)
                
                
                
                
                
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
