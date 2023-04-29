//
//  Artist.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let externalUrls: [String: String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.type = try values.decode(String.self, forKey: .type)
        self.images = try values.decode([APIImage].self, forKey: .images)
        self.externalUrls = try values.decode([String: String].self, forKey: .externalUrls)
    }
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id, name, type, images
    }
}
