//
//  WorkoutFormType.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

enum WorkoutFormType: Identifiable, View {
    case new
    case update(Workout)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }

    var body: some View {
        switch self {
        case .new:
            return WorkoutFormView(viewModel: WorkoutFormViewModel()).environment(\.colorScheme, .light)
        case .update(let workout):
            return WorkoutFormView(viewModel: WorkoutFormViewModel(workout)).environment(\.colorScheme, .light)
        }
    }
}
