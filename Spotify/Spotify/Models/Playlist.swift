//
//  Playlist.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
