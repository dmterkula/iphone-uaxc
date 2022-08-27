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
    
    var body: some View {
        VStack {
            Text("UAXC PRs")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            
            HStack {
                Text("Runners Before Grad Class: ")
                TextField("2022", text: $lastIncludedGradClass)
                    .keyboardType(.default)
            }
            .padding(.top, 20)
            
            PRList(prs: prList)
            
            
            Button("Get PRs") {
               
                let dataService = DataService()
                dataService.fetchPRs(lastIncludedGradClass: lastIncludedGradClass) { (result) in
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
            
            Spacer()
        }
    }
}

