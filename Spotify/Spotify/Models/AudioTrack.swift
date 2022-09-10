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
        self.available_markets = (try? container.decode([String].self, forKey: .availableMarkets)) ?? []
        self.disc_number = (try? container.decode(Int.self, forKey: .discNumber)) ?? 0
        self.duration_ms = (try? container.decode(Int.self, forKey: .durationMS)) ?? 0
        self.explicit = (try? container.decode(Bool.self, forKey: .explicit)) ?? false
        self.external_urls = (try? container.decode([String: String].self, forKey: .externalUrls)) ?? [:]
        self.id = (try? container.decode(String.self, forKey: .id)) ?? ""
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.preview_url = try? container.decode(String.self, forKey: .album)
    }
}
