//
//  LoginView.swift
//  UAXC
//
//  Created by David  Terkula on 10/2/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppVersionChecker
    
    @State private var showingCompatibilityAlert = false
    
    var body: some View {
        VStack {
            
            Text("Welcome to UAXC")
                .font(.system(.largeTitle, design: .rounded))
            
            Text("Please log in")
                .font(.system(.largeTitle, design: .rounded))
            
                
            TextField("Username", text: $loginViewModel.credentials.username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
            SecureField("Password", text: $loginViewModel.credentials.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
            
            if (loginViewModel.showProgressView) {
                ProgressView()
            }
            
            Button() {
                if (appInfo.needsUpdate) {
                    showingCompatibilityAlert = true
                } else {
                    loginViewModel.login { success in
                        authentication.updateValidation(success: success)
                    }
                }
            } label: {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .disabled(loginViewModel.loginDisabled)
            .alert("Good news! There is an update available with new features or critical big fixes. Please update your app to proceed", isPresented: $showingCompatibilityAlert) {
                       Button("OK", role: .cancel) { }
                   }
        }
        .onAppear {
            appInfo.updateCompatibility()
        }
        .disabled(loginViewModel.showProgressView)
        .alert(item: $loginViewModel.error) { error in
            Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
