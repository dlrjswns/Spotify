//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/01.
//

import Foundation

struct NewReleasesResponse: Decodable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Decodable {
    let items: [Album]
}

struct Album: Decodable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.album_type = (try? values.decode(String.self, forKey: .albumType)) ?? ""
        self.available_markets = (try? values.decode([String].self, forKey: .availableMarkets)) ?? []
        self.id = try values.decode(String.self, forKey: .id)
        self.images = try values.decode([APIImage].self, forKey: .images)
        self.name = try values.decode(String.self, forKey: .name)
        self.release_date = try values.decode(String.self, forKey: .releaseDate)
        self.total_tracks = try values.decode(Int.self, forKey: .totalTracks)
        self.artists = try values.decode([Artist].self, forKey: .albumType)
    }
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case totalTracks = "total_tracks"
        case releaseDate = "release_date"
        case id, images, name, artists
    }
}
