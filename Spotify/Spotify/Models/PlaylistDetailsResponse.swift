//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/12.
//

import Foundation

struct PlaylistDetailsResponse: Decodable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Decodable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Decodable {
    let track: AudioTrack
}
