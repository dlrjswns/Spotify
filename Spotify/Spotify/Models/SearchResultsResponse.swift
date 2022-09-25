//
//  SearchResultsResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/25.
//

import Foundation

struct SearchResultsResponse: Decodable {
    let albums: SearchAlbumResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTrackssResponse
}

struct SearchAlbumResponse: Decodable {
    let items: [Album]
}

struct SearchArtistsResponse: Decodable {
    let items: [Artist]
}

struct SearchPlaylistsResponse: Decodable {
    let items: [Playlist]
}

struct SearchTrackssResponse: Decodable {
    let items: [AudioTrack]
}
