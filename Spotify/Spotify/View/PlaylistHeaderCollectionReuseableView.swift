//
//  PlaylistHeaderCollectionReuseableView.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/18.
//

import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
  func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReuseableView)
}

final class PlaylistHeaderCollectionReuseableView: UICollectionReusableView {
  
  static let identifier = "PlaylistHeaderCollectionReuseableView"
  
  weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    label.sizeToFit()
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  
  private let ownerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 18, weight: .light)
    return label
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: "photo")
    return imageView
  }()
  
  private let playAllButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .systemGreen
    let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
    button.setImage(image, for: .normal)
    button.tintColor = .white
    button.layer.cornerRadius = 30
    button.layer.masksToBounds = true
    button.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func didTapPlayAll() {
    delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.heightAnchor.constraint(equalToConstant: frame.height / 1.8).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: frame.height / 1.8).isActive = true
    
    nameLabel.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
    
    descriptionLabel.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
    
    ownerLabel.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
    
    playAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width - 80).isActive = true
    playAllButton.topAnchor.constraint(equalTo: topAnchor, constant: frame.height - 80).isActive = true
  }
  
  private func configureUI() {
    _ = [nameLabel, descriptionLabel, ownerLabel, imageView, playAllButton].map {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    nameLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    
    descriptionLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    
    ownerLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    ownerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    ownerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
    
    playAllButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    playAllButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
  }
  
  func configure(with viewModel: PlaylistHeaderViewViewModel) {
    nameLabel.text = viewModel.name
    ownerLabel.text = viewModel.ownerName
    descriptionLabel.text = viewModel.description
    imageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
  }
}
