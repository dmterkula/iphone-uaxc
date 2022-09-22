//
//  RunnerMetGoalsDisclosureGroup.swift
//  UAXC
//
//  Created by David  Terkula on 9/21/22.
//

import SwiftUI

struct RunnerMetGoalsDisclosureGroup: View {
    
    @Binding var metGoalsNameFilter: String
    @Binding var metGoals: [RunnerToMetGoal]
    @Binding var metGoalsIsExpanded: Bool
    var geometry: GeometryProxy
    
    var body: some View {
        ScrollView {
            DisclosureGroup(isExpanded: $metGoalsIsExpanded) {
                
                HStack{
                    TextField("Filter by name: ", text: $metGoalsNameFilter)
                }
                
                if (metGoalsNameFilter.isEmpty) {
                    ForEach($metGoals) { goal in
                        RunnerMetGoalsRow(runner: goal.wrappedValue.runner.name, metGoals: goal.wrappedValue.metGoals)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                } else {
                    ForEach(metGoals.filter { $0.runner.name.contains($metGoalsNameFilter.wrappedValue) }) { goal in
                        RunnerMetGoalsRow(runner: goal.runner.name, metGoals: goal.metGoals)
                        CustomDivider(color: .white, height: 2)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: geometry.size.width * 0.95)
                }
               
            } label: {
                Text("Met Goals")
                .onTapGesture {
                    withAnimation {
                        self.metGoalsIsExpanded.toggle()
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

//struct RunnerMetGoalsDisclosureGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerMetGoalsDisclosureGroup()
//    }
//}
