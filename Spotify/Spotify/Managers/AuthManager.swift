//
//  AuthManager.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    struct Constant {
        static let cliendID = "d3ca90fbc4324a61baa8cf8fdf6654e6"
        static let clientSecret = "b6213e4d80274920a6668f5b0e9fa901"
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
