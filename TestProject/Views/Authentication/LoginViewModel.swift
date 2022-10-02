//
//  LoginViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 10/2/22.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    let dataService = DataService()
    @Published var credentials: Credentials = Credentials()
    @Published var showProgressView: Bool = false
    @Published var authenticationResponse: AuthenticationResponse? = nil
    @Published var error: Authentication.AuthenticationError?
    
    var loginDisabled: Bool {
        credentials.username.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (AuthenticationResponse) -> Void) {
        showProgressView = true
        dataService.authenticateUser(credentials: credentials) { [unowned self] (result: Result<AuthenticationResponse, Authentication.AuthenticationError>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    showProgressView = false
                    authenticationResponse = response
                    completion(authenticationResponse!)
                case .failure(let authError):
                    showProgressView = false
                    credentials = Credentials()
                    error = authError
                    completion(AuthenticationResponse(authenticated: false))
                }
            }
        }
    }
}

//struct LoginViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginViewModel()
//    }
//}
