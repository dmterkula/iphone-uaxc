//
//  RunnerAccountFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 1/6/23.
//

import Foundation

class RunnerAccountFormViewModel: ObservableObject {
    
    var runner: Runner? = nil
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var role: String = "runner"
    @Published var runnerId: Int? = nil
    
    var possibleRoles: [String] = ["runner"]
    
    init(runnerAccount: RunnerAccount) {
        
        self.runner = runnerAccount.runner
        
        self.username = runnerAccount.appUser.username
        self.password = runnerAccount.appUser.password
        self.role = runnerAccount.appUser.role
        self.runnerId = runnerAccount.appUser.runnerId
    }
    
    init() {
        
    }
    
    func isComplete() -> Bool {
        if (username != "" && password != "" && role != "" && runnerId != nil) {
            return true
        } else {
            return false
        }
    }
    
}
