//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by 이건준 on 2023/04/19.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
