//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/27.
//

import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
  func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
  func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
  func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView)
  func playerControlsView(_ playerControlView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
  let title: String?
  let subtitle: String?
}

final class PlayerControlsView: UIView {
  
  weak var delegate: PlayerControlsViewDelegate?
  
  private var isPlaying = true
  
  private let volumeSlider: UISlider = {
    let slider = UISlider()
    slider.value = 0.5
    return slider
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let backButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.tintColor = .label
    button.setImage(image, for: .normal)
    return button
  }()
  
  private let nextButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.tintColor = .label
    button.setImage(image, for: .normal)
    return button
  }()
  
  private let playPauseButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    button.tintColor = .label
    button.setImage(image, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    subtitleLabel.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
    subtitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    volumeSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    volumeSlider.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
    volumeSlider.widthAnchor.constraint(equalToConstant: bounds.width - 20).isActive = true
    volumeSlider.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    playPauseButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 30).isActive = true
    playPauseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    playPauseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
    nextButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 80).isActive = true
    
    backButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
    backButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -80).isActive = true
  }
  
  private func configureUI() {
    backgroundColor = .clear
    clipsToBounds = true
    [nameLabel, subtitleLabel, volumeSlider, backButton, nextButton, playPauseButton].map {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
    nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    volumeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
    
  }
  
  public func configureUI(with viewModel: PlayerControlsViewViewModel) {
    nameLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
  }
  
  @objc private func didSlideSlider(_ slider: UISlider) {
    let value = slider.value
    delegate?.playerControlsView(self, didSlideSlider: value)
  }
  
  @objc private func didTapBack() {
    delegate?.playerControlsViewDidTapBackwardsButton(self)
  }
  
  @objc private func didTapPlayPause() {
    self.isPlaying = !isPlaying
    delegate?.playerControlsViewDidTapPlayPauseButton(self)
    
    // Update icon
    let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
    playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
  }
  
  @objc private func didTapNext() {
    delegate?.playerControlsViewDidTapForwardButton(self)
  }
}
