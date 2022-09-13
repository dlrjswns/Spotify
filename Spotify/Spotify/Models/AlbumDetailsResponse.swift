//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/11.
//

import Foundation

struct AlbumDetailsResponse: Decodable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse
}

struct TracksResponse: Decodable {
    let items: [AudioTrack]
}
