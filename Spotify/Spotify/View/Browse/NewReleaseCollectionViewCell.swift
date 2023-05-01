//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/06.
//

import UIKit

import SnapKit

final class NewReleaseCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "NewReleaseCollectionViewCell"
  
  private let albumCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let albumNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    label.numberOfLines = 2
    label.lineBreakMode = .byTruncatingTail
    return label
  }()
  
  private let numberOfTracksNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .light)
    label.numberOfLines = 0
    return label
  }()
  
  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .regular)
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    albumNameLabel.text = nil
    numberOfTracksNameLabel.text = nil
    artistNameLabel.text = nil
    albumCoverImageView.image = nil
  }
  
  private func configureUI() {
    contentView.backgroundColor = .secondarySystemBackground
    _ = [albumCoverImageView, albumNameLabel, artistNameLabel, numberOfTracksNameLabel].map{ contentView.addSubview($0) }
    albumCoverImageView.snp.makeConstraints {
      $0.directionalVerticalEdges.leading.equalToSuperview()
      $0.width.equalTo(contentView.bounds.height)
    }
    
    albumNameLabel.snp.makeConstraints {
      $0.top.trailing.equalToSuperview()
      $0.leading.equalTo(albumCoverImageView.snp.trailing).offset(5)
    }
    
    artistNameLabel.snp.makeConstraints {
      $0.leading.equalTo(albumNameLabel)
      $0.top.equalTo(albumNameLabel.snp.bottom)
    }
    
    numberOfTracksNameLabel.snp.makeConstraints {
      $0.top.equalTo(artistNameLabel.snp.bottom)
      $0.leading.equalTo(albumNameLabel)
      $0.bottom.equalTo(albumCoverImageView)
    }
    
  }
  
  public func configureUI(with viewModel: NewReleasesCellViewModel) {
    albumNameLabel.text = viewModel.name
    artistNameLabel.text = viewModel.artistName
    numberOfTracksNameLabel.text = "Tracks = \(viewModel.numberOfTracks)"
    albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
  }
}
