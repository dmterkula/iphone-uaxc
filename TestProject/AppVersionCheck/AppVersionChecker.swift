//
//  AppVersionChecker.swift
//  UAXC
//
//  Created by David  Terkula on 11/12/22.
//

import Foundation

class AppVersionChecker: ObservableObject {
    
    let dataService = DataService()
    
    @Published var needsUpdate: Bool = false
    
    func updateCompatibility() {
        
        dataService.getBackEndAppInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let appInfoResponse):
                    print(appInfoResponse)
                    let backEndVersion = appInfoResponse.app.version
                    
                    if (backEndVersion != "1.0.0") {
                        self.needsUpdate = true
                    }
                    
                    case .failure(let error):
                        print(error)
                }
            }
            
        }
        
    }
    
}
