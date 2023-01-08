//
//  RunnerAccountFormView.swift
//  UAXC
//
//  Created by David  Terkula on 1/6/23.
//

import SwiftUI

struct RunnerAccountFormView: View {
    
    @ObservedObject var viewModel: RunnerAccountFormViewModel
    @Binding var showEditSheet: Bool
    @Binding var refreshNeeded: Bool
    @Binding var existingUsernames: [String]
    
    var body: some View {
     
        VStack {
            if (viewModel.runner == nil) {
                RunnerAccountAddFormView(viewModel: viewModel, showEditSheet: $showEditSheet, refreshNeeded: $refreshNeeded, existingUsernames: $existingUsernames)
            } else {
                RunnerAccountEditFormView(viewModel: viewModel, showEditSheet: $showEditSheet, refreshNeeded: $refreshNeeded, existingUsernames: $existingUsernames)
            }
        }
        
    }
}


struct RunnerAccountEditFormView: View {
    
    @ObservedObject var viewModel: RunnerAccountFormViewModel
    @Binding var showEditSheet: Bool
    @Binding var refreshNeeded: Bool
    @Binding var existingUsernames: [String]
    
    @State var showUsernameLengthAlert: Bool = false
    @State var showPasswordLengthAlert: Bool = false
    
    @State var showUsernameAlreadyExistsAlert: Bool = false
    
    @State var startingUsername = ""
    
    let maxLength = 60
    
    let dataService = DataService()
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Runner Info (Read Only)")) {
             
                HStack {
                    Text("Name:")
                    Text(viewModel.runner!.name)
                }
                
                HStack {
                    Text("Grad. Class")
                    Text(viewModel.runner!.graduatingClass)
                }
                
            }
            
            Section(header: Text("Account Info")) {
                
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                
                TextField("Password", text: $viewModel.password)
                    .autocapitalization(.none)
                
                Picker("Role", selection: $viewModel.role) {
                    ForEach(viewModel.possibleRoles, id: \.self) {role in
                        Text(role)
                    }
                }
                
            }
            
            Section() {
                
                Button() {
                    
                    if (existingUsernames.contains(viewModel.username) && viewModel.username != startingUsername) {
                        showUsernameAlreadyExistsAlert = true
                    }
                    
                    if (viewModel.password.count > maxLength) {
                        showPasswordLengthAlert = true
                    }
                    
                    if (viewModel.username.count > maxLength) {
                        showUsernameLengthAlert = true
                    }
                    
                    if (!showUsernameAlreadyExistsAlert && !showPasswordLengthAlert && !showUsernameLengthAlert) {
                        
                        showEditSheet = false
                        refreshNeeded = true
                        
                        dataService.createAppUser(createAppUserRequest: CreateAppUserRequest(username: viewModel.username, password: viewModel.password, runnerId: viewModel.runnerId!, role: viewModel.role)) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    print(response)
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                        }
                    }
                } label: {
                    Text("Update")
                }
                .disabled(!viewModel.isComplete())
                
            }
        }
        .onAppear {
            startingUsername = viewModel.username
        }
        .alert("Username is too long, please shorten", isPresented: $showUsernameLengthAlert) {
            Button("OK", role: .cancel) {
                showUsernameLengthAlert.toggle()
                viewModel.username = ""
            }
        }
        .alert("Password is too long, please shorten", isPresented: $showPasswordLengthAlert) {
            Button("OK", role: .cancel) {
                showPasswordLengthAlert.toggle()
                viewModel.password = ""
            }
        }
        .alert("The username already exists, please pick a new one", isPresented: $showUsernameAlreadyExistsAlert) {
            Button("OK", role: .cancel) {
                showUsernameAlreadyExistsAlert.toggle()
            }
        }
        // end form
    }
}

struct RunnerAccountAddFormView: View {
    
    @State var runnersWithoutAccount: [Runner] = []
    @State var runner: Runner? = nil
    @State var runnerLabel: String = ""
    @State var season: String = Date().getYear()
    @State var seasons: [String] = [Date().getYear()]
    @ObservedObject var viewModel: RunnerAccountFormViewModel
    @Binding var showEditSheet: Bool
    @Binding var refreshNeeded: Bool
    @Binding var existingUsernames: [String]
    
    @State var showUsernameLengthAlert: Bool = false
    @State var showPasswordLengthAlert: Bool = false
    
    @State var showUsernameAlreadyExistsAlert: Bool = false
    
    let maxLength = 60
    
    let dataService = DataService()
    
    func getRunnersWithoutAccount() {
        dataService.getRunnersWithoutAccountForSeason(season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    runnersWithoutAccount = response
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    
    func fetchSeasons() {
        dataService.fetchMeetInfo() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meetInfoResponse):
                    seasons += Array(Set(meetInfoResponse.meets.flatMap { $0.dates.map{$0.components(separatedBy: "-")[0]} })).sorted().reversed()
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            Form {
                Section(header: Text("Season")) {
                    SeasonPickerViewLight(seasons: $seasons, season: $season)
                        .onChange(of: season) { newValue in
                            getRunnersWithoutAccount()
                        }
                }
                
                Section(header: Text("Runner")) {
                    RunnerPickerViewLight(runners: $runnersWithoutAccount, runnerLabel: $runnerLabel)
                        .onChange(of: runnerLabel) { newValue in
                            runner = runnersWithoutAccount.first{$0.name == runnerLabel.components(separatedBy: ":")[0]}
                            viewModel.runner = runner
                            viewModel.runnerId = runner?.runnerId
                        }
                }
                
                if (runner != nil) {
                    Section(header: Text("Account Info")) {
                        
                        TextField("Username", text: $viewModel.username)
                            .autocapitalization(.none)
                        
                        TextField("Password", text: $viewModel.password)
                            .autocapitalization(.none)
                        
                        Picker("Role", selection: $viewModel.role) {
                            ForEach(viewModel.possibleRoles, id: \.self) {role in
                                Text(role)
                            }
                        }
                        
                    }
                    
                    Section() {
                        
                        Button() {
                            
                            
                            if (existingUsernames.contains(viewModel.username)) {
                                showUsernameAlreadyExistsAlert = true
                            }
                            
                            if (viewModel.password.count > maxLength) {
                                showPasswordLengthAlert = true
                            }
                            
                            if (viewModel.username.count > maxLength) {
                                showUsernameLengthAlert = true
                            }
                            
                            if (!showUsernameAlreadyExistsAlert && !showPasswordLengthAlert && !showUsernameLengthAlert) {
                                
                                showEditSheet = false
                                refreshNeeded = true
                                
                                dataService.createAppUser(createAppUserRequest: CreateAppUserRequest(username: viewModel.username, password: viewModel.password, runnerId: viewModel.runnerId!, role: viewModel.role)) { (result) in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let response):
                                            print(response)
                                            case .failure(let error):
                                                print(error)
                                        }
                                    }
                                }
                            }
                           
                            
                        } label: {
                            Text("Create")
                        }
                        .disabled(!viewModel.isComplete())
                        
                    }
                }
            }.alert("Username is too long, please shorten", isPresented: $showUsernameLengthAlert) {
                Button("OK", role: .cancel) {
                    showUsernameLengthAlert.toggle()
                    viewModel.username = ""
                }
            }
            .alert("Password is too long, please shorten", isPresented: $showPasswordLengthAlert) {
                Button("OK", role: .cancel) {
                    showPasswordLengthAlert.toggle()
                    viewModel.password = ""
                }
            }
            .alert("The username already exists, please pick a new one", isPresented: $showUsernameAlreadyExistsAlert) {
                Button("OK", role: .cancel) {
                    showUsernameAlreadyExistsAlert.toggle()
                }
            }
            
            // end form
        }
        .onAppear {
            fetchSeasons()
            getRunnersWithoutAccount()
            
        }
    }
    
}


//struct RunnerAccountFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerAccountFormView()
//    }
//}
