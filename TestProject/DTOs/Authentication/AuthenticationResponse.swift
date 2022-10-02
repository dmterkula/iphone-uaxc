//
//  AuthenticationResponse.swift
//  UAXC
//
//  Created by David  Terkula on 10/2/22.
//

import Foundation

struct AuthenticationResponse: Codable {
    
    var authenticated: Bool
    var user: AppUser?
    
}

struct AppUser: Codable {
    
    var username: String
    var password: String
    var role: String
    
}
