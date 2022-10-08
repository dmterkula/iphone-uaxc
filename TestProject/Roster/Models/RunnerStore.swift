//
//  RunnerStore.swift
//  UAXC
//
//  Created by David  Terkula on 10/5/22.
//

import Foundation

@MainActor
class RunnerStore: ObservableObject {
 
    @Published var roster = [Runner]()
    @Published var preview: Bool
    
    let dataService = DataService()

    init(preview: Bool = false) {
        self.preview = preview
        fetchRoster(getActiveOnly: true)
    }
    
    func fetchRoster(getActiveOnly: Bool) -> Void {
        
        var currentYearString: String = String(Date().formatted(date: .abbreviated,
                                                                time: .omitted).suffix(4))
        
        dataService.fetchPossibleRunners(season: currentYearString, filterForIsActive: getActiveOnly) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let runnersResponse):
                    self.roster = runnersResponse
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    func fetchRosterGivenYear(givenSeason: String, getActiveOnly: Bool) -> Void {
        
        dataService.fetchPossibleRunners(season: givenSeason, filterForIsActive: getActiveOnly) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let runnersResponse):
                    self.roster = runnersResponse
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    
    func add(_ runner: Runner) {
        
        if (preview) {
            roster.append(runner)
        } else {
            dataService.createRunner(name: runner.name, graduatingClass: runner.graduatingClass, isActive: runner.isActive) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            self.roster.append(response!)
                            self.roster = self.roster.sorted(by: {
                                $0.graduatingClass < $1.graduatingClass
                            })
                        
                            case .failure(let error):
                                print(error)
                        }
                    }
            }
        }
        
        
    }
    
    
    func update(_ runner: Runner) {
        
        if (preview) {
            if let index = roster.firstIndex(where: {$0.runnerId == runner.runnerId}) {
              
                roster[index].name = runner.name
                roster[index].graduatingClass = runner.graduatingClass
                roster[index].isActive = runner.isActive
            }
            
        }
        else {
            if let index = roster.firstIndex(where: {$0.runnerId == runner.runnerId}) {
                roster[index] = runner
                
                dataService.updateRunner(name: runner.name, runnerId: runner.runnerId, graduatingClass: runner.graduatingClass, isActive: runner.isActive) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            if (response != nil) {
                                print(response)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                }
            }
            else {
                print("didn't update, fail to find matching workout")
            }
        }
    }
    
    
}
