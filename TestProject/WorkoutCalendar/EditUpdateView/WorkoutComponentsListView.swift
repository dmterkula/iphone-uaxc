//
//  WorkoutComponentsListView.swift
//  UAXC
//
//  Created by David  Terkula on 10/9/22.
//

import SwiftUI

struct WorkoutComponentsListView: View {
    
    var components: [WorkoutComponentFormViewModel]
    
    var body: some View {
        List {
            ForEach(components) { component in
                Text("Workout Component")
                WorkoutComponentFormView(viewModel: component)
            }
        }
    }
}

//struct WorkoutComponentsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutComponentsListView()
//    }
//}
