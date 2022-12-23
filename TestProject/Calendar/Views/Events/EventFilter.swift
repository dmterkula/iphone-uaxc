//
//  EventFilter.swift
//  UAXC
//
//  Created by David  Terkula on 12/21/22.
//

import SwiftUI

struct EventFilter: View {
    
    @Binding var filterForMeets: Bool
    @Binding var filterForWorkouts: Bool
    @Binding var filterForTraining: Bool
    
    var body: some View {
        HStack {
           
            CheckBoxView(checked: $filterForMeets)
                .onChange(of: filterForMeets) { newValue in
                    if (newValue == true) {
                        filterForWorkouts = false
                        filterForTraining = false
                       
                    }
                }
            
            Text("Meets")
            
            
            CheckBoxView(checked: $filterForWorkouts)
                .onChange(of: filterForWorkouts) { newValue in
                    if (newValue == true) {
                        filterForMeets = false
                        filterForTraining = false
                    }
                }
            Text("Workouts")
            
            
            CheckBoxView(checked: $filterForTraining)
                .onChange(of: filterForTraining) { newValue in
                    if (newValue == true) {
                        filterForMeets = false
                        filterForWorkouts = false
                    }
            }
            Text("Training")
        }
    }
}



//struct EventFilter_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFilter()
//    }
//}
