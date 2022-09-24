//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/20.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemMint
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    public func configureUI(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL)
        contentView.backgroundColor = colors.randomElement()
    }
}
