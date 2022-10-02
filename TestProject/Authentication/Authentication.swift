//
//  Authentication.swift
//  UAXC
//
//  Created by David  Terkula on 10/2/22.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValdiated = false
    @Published var user: AppUser? = nil
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Either your username or password are invalid. Please try again or contact Coach David", comment: "")
            }
        }
    }
    
    func updateValidation(success: AuthenticationResponse) {
        withAnimation {
            isValdiated = success.authenticated
            user = success.user
        }
    }
    
}
