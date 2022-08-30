//
//  UserProfile.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

struct UserProfile: Decodable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Int]
    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}
