//
//  PlayerViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
  func didTapPlayPause()
  func didTapForward()
  func didTapBackward()
  func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
  
  weak var dataSource: PlayerDataSource?
  weak var delegate: PlayerViewControllerDelegate?
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .systemBlue
    return imageView
  }()
  
  private let controlsView = PlayerControlsView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    [imageView, controlsView].map {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    controlsView.delegate = self
    configureBarButtons()
    configure()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
    
    controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    controlsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    controlsView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive
     = true
    controlsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    
  }
  
  private func configure() {
    imageView.sd_setImage(with: dataSource?.imageURL)
    controlsView.configureUI(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
  }
  
  private func configureBarButtons() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
  }
  
  @objc private func didTapClose() {
    dismiss(animated: true)
  }
  
  @objc private func didTapAction() {
    // Actions
  }
  
  func refreshUI() {
    configure()
  }
  
}

extension PlayerViewController: PlayerControlsViewDelegate {
  func playerControlsView(_ playerControlView: PlayerControlsView, didSlideSlider value: Float) {
    delegate?.didSlideSlider(value)
  }
  
  func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapPlayPause()
  }
  
  func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapForward()
  }
  
  func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView) {
    delegate?.didTapBackward()
  }
}
