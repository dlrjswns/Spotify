//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/06.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "FeaturedPlaylistCollectionViewCell"
  
  private let playlistCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 4
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let playlistNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .regular)
    return label
  }()
  
  private let creatorNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 15, weight: .thin)
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
    playlistNameLabel.text = nil
    playlistCoverImageView.image = nil
    creatorNameLabel.text = nil
  }
  
  public func configureUI(with viewModel: FeaturedPlaylistCellViewModel) {
    playlistNameLabel.text = viewModel.name
    playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    creatorNameLabel.text = viewModel.creatorName
  }
  
  private func configureUI() {
    _ = [playlistCoverImageView, playlistNameLabel, creatorNameLabel].map {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
    playlistCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    playlistCoverImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 70).isActive = true
    playlistCoverImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height - 70).isActive = true
    
    playlistNameLabel.centerYAnchor.constraint(equalTo: playlistCoverImageView.centerYAnchor).isActive = true
    playlistNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor, constant: 3).isActive = true
    
    creatorNameLabel.centerYAnchor.constraint(equalTo: playlistNameLabel.centerYAnchor).isActive = true
    creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor, constant: 3).isActive = true
    
  }
}
