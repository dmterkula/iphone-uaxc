//
//  RunnerFormType.swift
//  UAXC
//
//  Created by David  Terkula on 10/4/22.
//

import SwiftUI

enum RunnerFormType: Identifiable, View {
    case new
    case update(Runner)
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
            return RunnerFormView(viewModel: RunnerFormViewModel()).environment(\.colorScheme, .light)
        case .update(let runner):
            return RunnerFormView(viewModel: RunnerFormViewModel(runner)).environment(\.colorScheme, .light)
        }
    }
}
