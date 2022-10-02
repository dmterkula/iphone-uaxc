//
//  WorkoutPlanView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutPlanView: View {
    
    var workout: Workout
    let dataService = DataService()
    
    @State var workoutPlanDisclosureGroupisExpanded: Bool = false
    
    @State var workoutPlanResponse: WorkoutPlanResponse?
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Background().edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Section {
                            VStack {

                                Text(workout.date.formatted(date: .abbreviated,
                                                            time: .omitted))
                                .font(.system(.largeTitle, design: .rounded))
                                .foregroundColor(Color(red: 14/255, green: 99/255, blue: 0/255))

                                Text(workout.title)
                                    .font(.system(.largeTitle, design: .rounded))
                                    .foregroundColor(Color(red: 14/255, green: 99/255, blue: 0/255))
                                    .padding(.bottom, 10)

                                HStack {
                                    Spacer()
                                    HStack {
                                        Text("Type: ")
                                            .foregroundColor(.white)
                                            .font(.system(.headline, design: .rounded))
                                        Text(workout.type)
                                            .foregroundColor(.white).bold()
                                            .font(.system(.headline, design: .rounded))
                                    }
                                    
                                    Spacer()
                                    
                                    if (workout.type == "Interval") {
                                        HStack {
                                            Text("Reps: ")
                                                .foregroundColor(.white)
                                                .font(.system(.headline, design: .rounded))
                                            Text(String(workout.targetCount))
                                                .foregroundColor(.white).bold()
                                                .font(.system(.headline, design: .rounded))
                                        }
                                    } else {
                                        HStack {
                                            Text("Duration: ")
                                                .foregroundColor(.white)
                                                .font(.system(.headline, design: .rounded))
                                            Text(String(workout.duration))
                                                .foregroundColor(.white).bold()
                                                .font(.system(.headline, design: .rounded))
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Pace: ")
                                            .foregroundColor(.white)
                                            .font(.system(.headline, design: .rounded))
                                        Text(workout.pace)
                                            .foregroundColor(.white).bold()
                                            .font(.system(.headline, design: .rounded))
                                        if (!workout.paceAdjustment.isEmpty && workout.paceAdjustment != "0:00.0") {
                                            if (workout.paceAdjustment.contains("-")) {
                                                Text(workout.paceAdjustment)
                                            } else {
                                                Text("+" + workout.paceAdjustment)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }
                        }.padding(.bottom, 15)
                       
                        
                        Button("Get Workout Plan") {
                            
                            dataService.getWorkoutPlan(workout: workout) { (result) in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let response):
                                        workoutPlanResponse = response
                                        case .failure(let error):
                                            print(error)
                                    }
                                }
                            }
                            
                        }
                        .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.system(.title2, design: .rounded))
                        .buttonStyle(.bordered)
                        .tint(.white)
                        
                        
                        if (workoutPlanResponse != nil) {
                            DisclosureGroup(isExpanded: $workoutPlanDisclosureGroupisExpanded) {
                                WorkoutPlanSplitsView(runnerWorkoutPlans: workoutPlanResponse!.workoutPlans)
                            } label: {
                                Text("Workout Plan")
                                .onTapGesture {
                                withAnimation {
                                    self.workoutPlanDisclosureGroupisExpanded.toggle()
                                }
                            }
                        }
                            .background(.thinMaterial)
                            .frame(maxWidth: geometry.size.width * 0.95, maxHeight: .infinity)
                            .accentColor(.white)
                            .font(.system(.title, design: .rounded))
                        }
                        
                    }
                }
            }.environment(\.colorScheme, .dark)
            // end zstack
            
            }// end geometry 
        }
        
}

struct WorkoutPlanView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlanView(workout: (Workout.sampleWorkouts.first)!)
    }
}
