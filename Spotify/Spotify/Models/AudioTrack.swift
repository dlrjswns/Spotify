//
//  AudioTrack.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

struct AudioTrack: Decodable {
    var album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let preview_url: String?
}
