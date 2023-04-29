//
//  RecommendedGenresResponse.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/03.
//

import Foundation

struct RecommendedGenresResponse: Codable {
    let genres: [String]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = (try? container.decode([String].self, forKey: .genres)) ?? []
    }
}
