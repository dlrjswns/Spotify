//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/05.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
