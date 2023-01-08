//
//  RunnerAccountRowView.swift
//  UAXC
//
//  Created by David  Terkula on 1/6/23.
//

import SwiftUI

struct RunnerAccountRowView: View {
    
    @State var runnerAccount: RunnerAccount
    @State var showEditSheet: Bool = false
    @Binding var refreshNeeded: Bool
    @Binding var existingUsernames: [String]
    
    func closeEditSheet() {
        showEditSheet = false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Name")
                    .bold()
                Text(runnerAccount.runner.name)
                
                Button() {
                    showEditSheet = true
                } label: {
                    Text("Edit")
                }
                .sheet(isPresented: $showEditSheet, onDismiss: closeEditSheet) {
                    RunnerAccountFormView(viewModel: RunnerAccountFormViewModel(runnerAccount: runnerAccount), showEditSheet: $showEditSheet, refreshNeeded: $refreshNeeded, existingUsernames: $existingUsernames)
                        .preferredColorScheme(.light)
                }
                
            }
            
            HStack {
                Text("Grad. Class: ")
                    .bold()
                Text(runnerAccount.runner.graduatingClass)
            }
            
            HStack {
                Text("Role: ")
                    .bold()
                Text(runnerAccount.appUser.role)
            }
            
            HStack {
                Text("Username:")
                    .bold()
                
                Text(runnerAccount.appUser.username)
            }
            
            HStack {
                Text("Password:")
                    .bold()
                Text(runnerAccount.appUser.password)
            }
            
        }
    }
}

//struct RunnerAccountRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerAccountRowView()
//    }
//}
