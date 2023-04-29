//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/01.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    let artists: [Artist]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.albumType = (try? values.decode(String.self, forKey: .albumType)) ?? ""
        self.availableMarkets = (try? values.decode([String].self, forKey: .availableMarkets)) ?? []
        self.id = (try? values.decode(String.self, forKey: .id)) ?? ""
        self.images = (try? values.decode([APIImage].self, forKey: .images)) ?? []
        self.name = (try? values.decode(String.self, forKey: .name)) ?? ""
        self.releaseDate = (try? values.decode(String.self, forKey: .releaseDate)) ?? ""
        self.totalTracks = (try? values.decode(Int.self, forKey: .totalTracks)) ?? 0
        self.artists = (try? values.decode([Artist].self, forKey: .albumType)) ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case totalTracks = "total_tracks"
        case releaseDate = "release_date"
        case id, images, name, artists
    }
}
