//
//  RunnerComponentPlanView.swift
//  UAXC
//
//  Created by David  Terkula on 10/16/22.
//

import SwiftUI

struct RunnerComponentPlanView: View {
    
    var compPlan: ComponentPlans
    
    func convert(meters: Int) -> String {
        let miles: Double = (Double(meters) / 1609.0).rounded(toPlaces: 2)
        return String(miles)
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if (compPlan.duration == nil) {
                let miles: String = convert(meters: compPlan.distance)
                HStack {
                    Text("Target Distance: " + miles + " mi")
                }.padding(.leading, 5)
            } else {
                HStack {
                    Text("Target Duration: ")
                    Text(compPlan.duration!)
                }.padding(.leading, 5)
            }
            
            HStack {
                Text("Target Pace: " + compPlan.targetedPace[0].pace)
            }.padding(.leading, 5)
            
            HStack {
                Text("Base Time: " + compPlan.baseTime)
            }
            .padding(.leading, 5)
            .padding(.bottom, 8)
        }
    }
}
//
//struct RunnerComponentPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerComponentPlanView()
//    }
//}
