//
//  AuthResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/28.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
