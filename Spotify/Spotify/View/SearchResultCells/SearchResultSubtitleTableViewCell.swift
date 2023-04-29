//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/26.
//

import UIKit
import SDWebImage

struct SearchResultSubtitleTableViewCellViewModel {
  let title: String
  let subtitle: String
  let imageURL: URL?
}

final class SearchResultSubtitleTableViewCell: UITableViewCell {
  
  static let identfier = "SearchResultSubtitleTableViewCell"
  
  private let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.numberOfLines = 1
    return label
  }()
  
  private let iconImageViewe: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(label)
    contentView.addSubview(subtitleLabel)
    contentView.addSubview(iconImageViewe)
    contentView.clipsToBounds = true
    accessoryType = .disclosureIndicator
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    iconImageViewe.image = nil
    label.text = nil
    subtitleLabel.text = nil
  }
  
  func configureUI(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
    label.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    iconImageViewe.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
  }
}
