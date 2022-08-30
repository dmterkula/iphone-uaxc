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
                    HomePageView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MainMenuView(showMenu: $showMenu)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }.gesture(drag)
                
            }.navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
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
                .foregroundColor(Color.blue)
            
            Spacer().frame(minHeight:100, maxHeight: 600)
        }
    }
}

struct MainMenuView: View {
    
    @Binding var showMenu: Bool
    @State private var viewSelection: String? = nil
    
    var body: some View {
            
        VStack(alignment: .leading) {
            
            TabButton(title: "PRs", image: "person")
                .padding(.top, 120)
            
            TabButton(title: "Meet Results", image: "person.3")
                .padding(.top, 30)

            
            TabButton(title: "Meet Splits", image: "stopwatch")
                .padding(.top, 30)
            
            TabButton(title: "Meet Summary", image: "book")
                .padding(.top, 30)
            
            TabButton(title: "Home", image: "house")
                .padding(.top, 30)
            
            Spacer()
        }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(red: 32/255, green: 32/255, blue: 32/255))
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
            }
            else {
                HomePageView(showMenu: $showMenu)
            }
    
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .foregroundColor(.gray)
                    .imageScale(.large)
                
                Text(title)
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
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
