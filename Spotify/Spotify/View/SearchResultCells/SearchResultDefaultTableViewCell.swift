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

final class SearchResultDefaultTableViewCell: UITableViewCell {
  
  static let identifier = "SearchResultDefaultTableViewCell"
  
  private let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()
  
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    iconImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.height - 10).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height - 10).isActive = true
  }
  
  private func configureUI() {
    _ = [label, iconImageView].map {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
    
    iconImageView.layer.cornerRadius = (contentView.bounds.height - 10) / 2
    iconImageView.layer.masksToBounds = true
    
    label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
    
    
    accessoryType = .disclosureIndicator
  }
  
  public func configureUI(with model: SearchResultDefaultTableViewCellViewModel) {
    label.text = model.title
    iconImageView.sd_setImage(with: model.imageURL)
  }
}
