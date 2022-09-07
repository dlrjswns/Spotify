//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/06.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
    }
}
