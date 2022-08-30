//
//  GetPRsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct GetPRsView: View {
    
    @State var lastIncludedGradClass = ""
    @State var prList: [Performance] = []
    @State var filter = ""
    
    var body: some View {
        VStack {
            Text("UAXC PRs")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
            HStack {
                Text("Oldest grad class included: ")
                TextField("2022", text: $lastIncludedGradClass)
                    .keyboardType(.default)
            }
            .padding(.top, 20)
            .onTapGesture {
                hideKeyboard()
            }
            
            HStack {
                Text("Filter by name: ")
                TextField("Maria", text: $filter)
                    .keyboardType(.default)
            }
            
            Spacer().frame(minHeight: 20, maxHeight: 30)
            
            
            
            Button("Get PRs") {
               
                let dataService = DataService()
                let intValue = Int(lastIncludedGradClass)! - 1
                let test = String(intValue)
                dataService.fetchPRs(lastIncludedGradClass: test) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let prDTO):
                            prList = prDTO.PRs
                            case .failure(let error):
                                print(error)
                        }
                    }
                    
                }
                
            }
            
            PerformanceList(performances: prList, filter: $filter)
            
        }
    }
}

