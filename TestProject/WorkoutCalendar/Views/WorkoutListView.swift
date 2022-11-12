//
//  WorkoutListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutListView: View {
    @EnvironmentObject var myWorkouts: WorkoutStore
    @EnvironmentObject var authentication: Authentication
    
    @State private var formType: WorkoutFormType?
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Text("Workouts")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, -1)
                        
                            .sheet(item: $formType) { $0 }
                        Spacer()
                        
                        if (authentication.user != nil && authentication.user!.role == "coach") {
                            Button {
                                formType = .new
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }.padding(.trailing, 10)
                        }
                    }
                    
                    
                    List {
                        ForEach(myWorkouts.workouts.sorted {$0.date < $1.date }) { workout in
                            WorkoutViewRow(workout: workout, formType: $formType)
                                .environmentObject(authentication)
                                .swipeActions {
                                    
                                    if (authentication.user != nil && authentication.user!.role == "coach") {
                                        Button(role: .destructive) {
                                            myWorkouts.delete(workout)
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: geometry.size.width * 0.95)
                    .sheet(item: $formType) { $0 }
                }
            }
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
            .environmentObject(WorkoutStore(preview: true))
    }
}
