//
//  PlaylistHeaderCollectionReuseableView.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/18.
//

import UIKit

class PlaylistHeaderCollectionReuseableView: UICollectionReusableView {
    
    static let identifier = "PlaylistHeaderCollectionReuseableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
