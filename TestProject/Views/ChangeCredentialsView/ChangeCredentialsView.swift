//
//  ChangeCredentialsView.swift
//  UAXC
//
//  Created by David  Terkula on 1/5/23.
//

import SwiftUI

struct ChangeCredentialsView: View {
    @EnvironmentObject var authentication: Authentication
    let dataService = DataService()
    
    let maxLength = 60
    
    @State var existingUsernames: [String] = []
    
    @State var newPassword = ""
    @State var newPasswordConfirmed = ""
    
    @State var newUsername = ""
    @State var newUsernameConfirmed = ""
    @State var showUsernameAlert: Bool = false
    
    @State var expandPasswordForm = false
    @State var expandUsernameForm = false
    @State var showPasswordAlert: Bool = false
    
    @State var showUsernameLengthAlert: Bool = false
    @State var showPasswordLengthAlert: Bool = false
    
    @State var showUsernameAlreadyExistsAlert: Bool = false
    
    @State var showSuccessAlert: Bool = false
    @State var showFailAlert: Bool = false
    
    
    func changeUsernameOrPassword(newUsernameInput: String?, newPasswordInput: String?) {
    
        if (newUsernameInput != nil) {
            
            var passwordParam = authentication.user!.password
            
            if (!newPassword.isEmpty && newPasswordInput != nil && newPassword != newPasswordInput) {
                passwordParam = newPasswordInput!
            }
            
            dataService.updateCredentials(username: authentication.user!.username, newUsername: newUsernameInput!, password: passwordParam) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if (response.success) {
                            authentication.user!.username = response.userName
                            authentication.user!.password = response.password
                            showSuccessAlert = true
                            fetchExistingUsernames()
                        } else {
                            showFailAlert = true
                        }
                        case .failure(let error):
                            showFailAlert = true
                            print(error)
                    }
                }
            }
            
        }
        
        if (newPasswordInput != nil) {
            
            var usernameParam = authentication.user!.username
            
            if (!newUsername.isEmpty && newUsernameInput != nil && newUsernameInput != authentication.user!.username) {
                usernameParam = newUsernameInput!
            }
            
            
            dataService.updateCredentials(username: authentication.user!.username, newUsername: usernameParam, password: newPasswordInput!) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if (response.success) {
                            authentication.user!.username = response.userName
                            authentication.user!.password = response.password
                            showSuccessAlert = true
                            fetchExistingUsernames()
                        } else {
                            showFailAlert = true
                        }
                        case .failure(let error):
                            showFailAlert = true
                            print(error)
                    }
                }
            }
            
        }
        
        
    }
    
    func fetchExistingUsernames() {
        
        dataService.getAllExistingUserNames() { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let usernames):
                    existingUsernames = usernames
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    
    
    var body: some View {
        ZStack {
            Background().edgesIgnoringSafeArea(.all)
                .onAppear() {
                    fetchExistingUsernames()
                }
            
            VStack {
                Text("Update Your Credentials")
                    .foregroundColor(.white)
                    .font(.title)
                
                Form {
                    Section(header: Text("Update usernmae")) {
                        
                        TextField("New Username", text: $newUsername)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                           
                            .autocapitalization(.none)
                        
                        TextField("Confirm new username", text: $newUsernameConfirmed)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .autocapitalization(.none)
                        
                        Button() {
                            showUsernameAlert = !(newUsername == newUsernameConfirmed)
                            showUsernameLengthAlert = newUsername.count > maxLength
                            
                            if (newUsername != authentication.user!.username && existingUsernames.contains(newUsername)) {
                                showUsernameAlreadyExistsAlert = true
                            } else {
                                if (!showUsernameAlert && !showUsernameLengthAlert) {
                                    changeUsernameOrPassword(newUsernameInput: newUsername, newPasswordInput: nil)
                                    print("make api call to change username")
                                }
                            }
                            
                           
                            
                        } label: {
                            Text("Update Username")
                        }
                        .disabled(newUsername.isEmpty || newUsernameConfirmed.isEmpty)
                    }
                    
                    Section(header: Text("Update password")) {
                        TextField("New Password", text: $newPassword)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .autocapitalization(.none)
                        
                        TextField("Confirm new password", text: $newPasswordConfirmed)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .autocapitalization(.none)
                        
                        Button() {
                            showPasswordAlert = !(newPassword == newPasswordConfirmed)
                            showPasswordLengthAlert = newPassword.count > maxLength
                            
                            if (!showPasswordAlert && !showPasswordLengthAlert) {
                                changeUsernameOrPassword(newUsernameInput: nil, newPasswordInput: newPassword)
                                print("make api call to change password")
                            }
                        } label: {
                            Text("Update Password")
                        }
                        .disabled(newPassword.isEmpty || newPasswordConfirmed.isEmpty)
                      
                    }
                }
                .alert("Entered usernames don't match", isPresented: $showUsernameAlert) {
                           Button("OK", role: .cancel) {
                               showUsernameAlert.toggle()
                   }
               }
                .alert("Entered passwords don't match", isPresented: $showPasswordAlert) {
                           Button("OK", role: .cancel) {
                               showPasswordAlert.toggle()
                   }
               }
                .alert("Username is too long, please shorten", isPresented: $showUsernameLengthAlert) {
                           Button("OK", role: .cancel) {
                               showUsernameLengthAlert.toggle()
                               newUsername = ""
                               newUsernameConfirmed = ""
                   }
               }
                .alert("Password is too long, please shorten", isPresented: $showPasswordLengthAlert) {
                           Button("OK", role: .cancel) {
                               showPasswordLengthAlert.toggle()
                               newPassword = ""
                               newPasswordConfirmed = ""
                   }
               }
                .alert("The username already exists, please pick a new one", isPresented: $showUsernameAlreadyExistsAlert) {
                           Button("OK", role: .cancel) {
                               showUsernameAlreadyExistsAlert.toggle()
                   }
               }
                .alert("Success!", isPresented: $showSuccessAlert) {
                           Button("OK", role: .cancel) {
                               showSuccessAlert.toggle()
                   }
               }
                .alert("Update Failed. Try again or let Coach David know.", isPresented: $showFailAlert) {
                           Button("OK", role: .cancel) {
                               showFailAlert.toggle()
                   }
               }
                
                Spacer()
                
            } // end vstack
        }
    }
}

struct ChangeCredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCredentialsView()
    }
}
