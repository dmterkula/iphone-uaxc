//
//  RunnerFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 10/4/22.
//

import Foundation

class RunnerFormViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var graduatingClass: String = ""
    @Published var isActive: Bool = true
    
    var id: String?
    var updating: Bool { id != nil }
    
    init() {}
    
    init(_ runner: Runner) {
        self.name = runner.name
        self.graduatingClass = runner.graduatingClass
        self.isActive = runner.isActive
        self.id = String(runner.runnerId)
    }
    
    var incomplete: Bool {
        name.isEmpty || graduatingClass.isEmpty
    }
    
}
