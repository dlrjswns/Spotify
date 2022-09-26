//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/26.
//

import UIKit
import SDWebImage

struct SearchResultDefaultTableViewCellViewModel {
    let title: String
    let imageURL: URL?
}

class SearchResultDefaultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
    }
    
    private func configureUI() {
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    public func configureUI(with model: SearchResultDefaultTableViewCellViewModel) {
        label.text = model.title
        imageView?.sd_setImage(with: model.imageURL)
    }
}
