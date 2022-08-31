//
//  SettingsModels.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/31.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
