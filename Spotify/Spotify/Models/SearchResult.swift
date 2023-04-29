//
//  SearchResult.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/25.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
