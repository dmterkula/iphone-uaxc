//
//  RunnerUnmetGoalsDisclosureGroup.swift
//  UAXC
//
//  Created by David  Terkula on 9/22/22.
//

import SwiftUI

struct RunnerUnmetGoalsDisclosureGroup: View {
    @Binding var unMetGoalsNameFilter: String
    @Binding var unMetGoals: [RunnerToUnmetGoal]
    @Binding var unMetGoalsIsExpanded: Bool
    var geometry: GeometryProxy
    
    @State var sortByClosest: Bool = true
    @State var sortByFurthest: Bool = false
    
    func sortUnMetGoals() {
        
        if (sortByClosest) {
            unMetGoals = unMetGoals.sorted{$0.difference < $1.difference}
        } else if (sortByFurthest) {
            unMetGoals = unMetGoals.sorted{$0.difference > $1.difference}
        }
    }
    
    var body: some View {
        ScrollView {
            DisclosureGroup(isExpanded: $unMetGoalsIsExpanded) {
                
                VStack {
                    HStack{
                        TextField("Filter by name: ", text: $unMetGoalsNameFilter)
                    }
                    HStack {
                        Button("Closest") {
                            sortByClosest = true
                            sortByFurthest = false
                            sortUnMetGoals()
                            
                        }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                            .font(.title2)
                        
                        Spacer()
                        
                        Button("Furthest") {
                            sortByFurthest = true
                            sortByClosest = false
                            sortUnMetGoals()
                            
                        }.foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                            .font(.title2)
                    }
                }
                
                if (unMetGoalsNameFilter.isEmpty) {
                    ForEach(unMetGoals) { goal in
                        RunnerUnmetGoalRow(runnerToUnmetGoal: goal)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                } else {
                    ForEach(unMetGoals.filter { $0.runner.name.contains($unMetGoalsNameFilter.wrappedValue) }) { goal in
                        RunnerUnmetGoalRow(runnerToUnmetGoal: goal)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                }
               
            } label: {
                Text("Unmet Goals")
                .onTapGesture {
                    withAnimation {
                        self.unMetGoalsIsExpanded.toggle()
                        }
                    }
                }
            .accentColor(.white)
            .font(.title3)
            .padding(.all)
            .background(.thinMaterial)
            .cornerRadius(8)
            .frame(width: geometry.size.width * 0.95)
        }
    }
}

//struct RunnerUnmetGoalsDisclosureGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerUnmetGoalsDisclosureGroup()
//    }
//}
