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
    var runner: Runner?
    
}

struct AppUser: Codable, Identifiable {
    
    var id = UUID()
    
    var username: String
    var password: String
    var role: String
    var runnerId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case username, password, role, runnerId
    }
    
}

struct RunnerAccount: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var appUser: AppUser
    
    private enum CodingKeys: String, CodingKey {
        case runner, appUser
    }
    
}
