//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/20.
//

import UIKit
import SDWebImage

final class CategoryCollectionViewCell: UICollectionViewCell {
  
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
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height / 2).isActive = true
    label.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20).isActive = true
    label.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2).isActive = true
    
    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.bounds.width / 2).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 2).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2).isActive = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    label.text = nil
  }
  
  private func configureUI() {
    _ = [imageView, label].map {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    
    
    imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    
    
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true
    
  }
  
  public func configureUI(with viewModel: CategoryCollectionViewCellViewModel) {
    label.text = viewModel.title
    imageView.sd_setImage(with: viewModel.artworkURL)
    contentView.backgroundColor = colors.randomElement()
  }
}
