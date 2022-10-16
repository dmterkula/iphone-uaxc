//
//  ViewAllGoalsDisclosureGroup.swift
//  UAXC
//
//  Created by David  Terkula on 9/22/22.
//

import SwiftUI

struct ViewAllGoalsDisclosureGroup: View {
    
    @Binding var allGoalsIsExpanded: Bool
    @Binding var allGoalsNameFilter: String
    var geometry: GeometryProxy
    
    @Binding var runnerGoals: [RunnersGoals]
    
    var body: some View {
        ScrollView {
            DisclosureGroup(isExpanded: $allGoalsIsExpanded) {
                
                HStack{
                    TextField("Filter by name: ", text: $allGoalsNameFilter)
                }
                
                if (allGoalsNameFilter.isEmpty) {
                    ForEach(runnerGoals) { goal in
                        StaticRunnerGoalsRow(runner: goal.runner.name, goals: goal.goals)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                } else {
                    ForEach(runnerGoals.filter { $0.runner.name.contains(allGoalsNameFilter) }) { goal in
                        StaticRunnerGoalsRow(runner: goal.runner.name, goals: goal.goals)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                }
               
            } label: {
                Text("All Goals")
                .onTapGesture {
                    withAnimation {
                        self.allGoalsIsExpanded.toggle()
                        }
                    }
                }
            .accentColor(.white)
            .font(.title3)
            .padding(.all)
            .background(.thinMaterial)
            .cornerRadius(8)
            .padding(.top)
            .frame(width: geometry.size.width * 0.95)
            
        }
    }
}

//
//struct ViewAllGoalsDisclosureGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewAllGoalsDisclosureGroup()
//    }
//}
