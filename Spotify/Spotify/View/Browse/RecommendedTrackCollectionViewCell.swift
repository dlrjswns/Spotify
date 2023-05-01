//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/06.
//

import UIKit

final class RecommendedTrackCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "RecommendedTrackCollectionViewCell"
  
  private let albumCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 18, weight: .regular)
    return label
  }()
  
  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 15, weight: .thin)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    trackNameLabel.text = nil
    albumCoverImageView.image = nil
    artistNameLabel.text = nil
  }
  
  private func configureUI() {
    contentView.backgroundColor = .secondarySystemBackground
    _ = [albumCoverImageView, trackNameLabel, artistNameLabel].map { contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    albumCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    albumCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    albumCoverImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    
    trackNameLabel.topAnchor.constraint(equalTo: albumCoverImageView.topAnchor).isActive = true
    trackNameLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 10).isActive = true
    
    artistNameLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor).isActive = true
    artistNameLabel.bottomAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor).isActive = true
  }
  
  func configure(with viewModel: RecommendedTrackCellViewModel) {
    trackNameLabel.text = viewModel.name
    albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    artistNameLabel.text = viewModel.artistName
  }
}
