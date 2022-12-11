//
//  LoggedTrainingRunRowView.swift
//  UAXC
//
//  Created by David  Terkula on 12/4/22.
//

import SwiftUI

struct LoggedTrainingRunView: View {
    var loggedRun: TrainingRunResultDTO
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray)
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Recorded Distance: ")
                        Text(String(loggedRun.distance))
                    }
                    
                    HStack {
                        Text("Recorded Time: ")
                        Text(loggedRun.time)
                    }
                    
                    HStack {
                        Text("Avg. Pace: ")
                        Text(loggedRun.avgPace)
                    }
                }
                
    //            NavigationLink(destination: IndividualComponentResultsView(component: component).environment(\.colorScheme, .light)) {
    //                EmptyView()
    //            }
    //            .opacity(0.0)
    //            .buttonStyle(PlainButtonStyle())
                
            }
        }
        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)


    }
}

//struct LoggedTrainingRunRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoggedTrainingRunRowView()
//    }
//}
