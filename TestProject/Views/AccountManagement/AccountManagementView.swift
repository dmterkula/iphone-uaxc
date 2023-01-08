//
//  AccountManagementView.swift
//  UAXC
//
//  Created by David  Terkula on 1/6/23.
//

import SwiftUI

struct AccountManagementView: View {
    
    @State var existingUsernames: [String] = []
    
    @State
    var allRunnerAccounts: [RunnerAccount] = []
    
    let dataService = DataService()
    
    @State var refreshNeeded: Bool = false
    
    @State var showEditSheet: Bool = false
    
    func fetchAllRunnerAccounts() {
        
        refreshNeeded = false
        dataService.getAllRunnerAccounts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let appUsersResponse):
                    allRunnerAccounts = appUsersResponse
                    existingUsernames = allRunnerAccounts.map{ $0.appUser.username }
                    
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Background().edgesIgnoringSafeArea(.all)
                .onAppear {
                    fetchAllRunnerAccounts()
            }
            
            VStack {
                Text("Account Management")
                    .font(.title)
                    .foregroundColor(.white)
                
                if (!allRunnerAccounts.isEmpty) {
                    
                    NavigationView {
                        List {
                            ForEach(allRunnerAccounts) { runnerAccount in
                                RunnerAccountRowView(runnerAccount: runnerAccount, refreshNeeded: $refreshNeeded, existingUsernames: $existingUsernames)
                                CustomDivider(color: GlobalFunctions.uaGreen(), height: 2)
                            }
                        }
                        .onChange(of: refreshNeeded) { newValue in
                            if (newValue == true) {
                                fetchAllRunnerAccounts()
                            }
                        }
                    }.toolbar {
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showEditSheet.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .sheet(isPresented: $showEditSheet, onDismiss: fetchAllRunnerAccounts) {
                                RunnerAccountAddFormView(viewModel: RunnerAccountFormViewModel(), showEditSheet: $showEditSheet, refreshNeeded: $refreshNeeded, existingUsernames: $existingUsernames)
                                    .preferredColorScheme(.light)
                            }
                        }
                    }
                }
                
                Spacer()
                
            }
        }
    }
}

//struct AccountManagementView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountManagementView()
//    }
//}
