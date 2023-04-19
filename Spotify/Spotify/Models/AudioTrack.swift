//
//  AudioTrack.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

struct AudioTrack: Codable {
    var album: Album?
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMS: Int
    let explicit: Bool
    let externalUrls: [String: String]
    let id: String
    let name: String
    let previewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case externalUrls = "external_urls"
        case previewUrl = "preview_url"
        case album, artists, explicit, id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.album = try? container.decode(Album.self, forKey: .album)
        self.artists = (try? container.decode([Artist].self, forKey: .album)) ?? []
        self.availableMarkets = (try? container.decode([String].self, forKey: .availableMarkets)) ?? []
        self.discNumber = (try? container.decode(Int.self, forKey: .discNumber)) ?? 0
        self.durationMS = (try? container.decode(Int.self, forKey: .durationMS)) ?? 0
        self.explicit = (try? container.decode(Bool.self, forKey: .explicit)) ?? false
        self.externalUrls = (try? container.decode([String: String].self, forKey: .externalUrls)) ?? [:]
        self.id = (try? container.decode(String.self, forKey: .id)) ?? ""
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.previewUrl = try? container.decode(String.self, forKey: .album)
    }
}
