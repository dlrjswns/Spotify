//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by 이건준 on 2023/04/30.
//

import UIKit

import SnapKit

protocol LibraryToggleViewDelegate: AnyObject {
  func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
  func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

final class LibraryToggleView: UIView {
  
  enum State {
    case playlist
    case album
  }
  
  var state: State = .playlist 
  
  weak var delegate: LibraryToggleViewDelegate?
  
  private let playlistButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("Playlists", for: .normal)
    return button
  }()
  
  private let albumsButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("Albums", for: .normal)
    return button
  }()
  
  private let indicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGreen
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 4
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    [playlistButton, albumsButton, indicatorView].forEach { addSubview($0) }
    playlistButton.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
      $0.width.equalTo(100)
      $0.height.equalTo(40)
    }
    
    albumsButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalTo(playlistButton.snp.trailing)
      $0.width.equalTo(100)
      $0.height.equalTo(40)
    }
    
    playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
    albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    
    indicatorView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.equalTo(playlistButton.snp.bottom)
      $0.width.equalTo(100)
      $0.height.equalTo(3)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  @objc private func didTapPlaylists() {
    state = .playlist
    UIView.animate(withDuration: 0.2) {
      self.layoutIndicator()
    }
    delegate?.libraryToggleViewDidTapPlaylists(self)
  }
  
  @objc private func didTapAlbums() {
    state = .album
    UIView.animate(withDuration: 0.2) {
      self.layoutIndicator()
    }
    delegate?.libraryToggleViewDidTapAlbums(self)
  }
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    layoutIndicator()
//  }
  
  func layoutIndicator() {
    print("레이아웃인디케이터 \(state)")
    switch state {
    case .playlist:
      indicatorView.snp.updateConstraints {
        $0.leading.equalToSuperview()
      }
    case .album:
      indicatorView.snp.updateConstraints {
        $0.leading.equalToSuperview().offset(100)
      }
    }
    self.layoutIfNeeded()
  }
  
  func update(for state: State) {
      self.state = state
      UIView.animate(withDuration: 0.2) {
        self.layoutIndicator()
      }
  }
}
