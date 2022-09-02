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
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
            VStack {
                Text("UAXC PRs")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                HStack {
                    Text("Oldest grad class included: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    TextField("2023", text: $lastIncludedGradClass)
                        .keyboardType(.default)
                        .foregroundColor(.white)
                        .placeholder(when: $lastIncludedGradClass.wrappedValue.isEmpty) {
                                Text("2023").foregroundColor(.white)
                        }
                        .opacity(0.75)
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
                
                HStack {
                    Text("Filter by name: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    TextField("Maria", text: $filter)
                        .placeholder(when: $filter.wrappedValue.isEmpty) {
                                Text("Maria").foregroundColor(.white)
                        }
                        .opacity(0.75)
                        .keyboardType(.default)
                        .foregroundColor(.white)
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
                    
                }.foregroundColor(.white)
                
                if (!prList.isEmpty) {
                    PerformanceList(performances: prList, filter: $filter)
                }
                
            }
        }

    }
}

