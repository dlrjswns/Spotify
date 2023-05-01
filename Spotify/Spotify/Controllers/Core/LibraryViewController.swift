//
//  LibraryViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

final class LibraryViewController: UIViewController {
  private let playlistsVC = LibraryPlaylistsViewController()
  private let albumsVC = LibraryAlbumsViewController()
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    return scrollView
  }()
  
  private let toggleView = LibraryToggleView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(toggleView)
    toggleView.delegate = self
    
    view.addSubview(scrollView)
    scrollView.contentSize = CGSize(width: view.bounds.width*2, height: scrollView.bounds.height)
    scrollView.delegate = self
    
    addChildren()
    updateBarButtons()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    scrollView.frame = CGRect(
      x: 0,
      y: view.safeAreaInsets.top+55,
      width: view.bounds.width,
      height: view.bounds.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
    )
    toggleView.frame = CGRect(
      x: 0,
      y: view.safeAreaInsets.top,
      width: 200,
      height: 55
    )
  }
  
  private func updateBarButtons() {
    switch toggleView.state {
    case .playlist:
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    case .album:
      navigationItem.rightBarButtonItem = nil
    }
  }
  
  @objc private func didTapAdd() {
    playlistsVC.showCreatePlaylistAlert()
  }
  
  private func addChildren() {
    addChild(playlistsVC)
    scrollView.addSubview(playlistsVC.view)
    playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
    playlistsVC.didMove(toParent: self)
    
    addChild(albumsVC)
    scrollView.addSubview(albumsVC.view)
    albumsVC.view.frame = CGRect(x: view.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
    albumsVC.didMove(toParent: self)
  }
}

extension LibraryViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.x >= (view.bounds.width-100) {
      toggleView.update(for: .album)
      updateBarButtons()
    }
    else {
      toggleView.update(for: .playlist)
      updateBarButtons()
    }
  }
}

extension LibraryViewController: LibraryToggleViewDelegate {
  func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
    scrollView.setContentOffset(.zero, animated: true)
    updateBarButtons()
  }
  
  func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
    scrollView.setContentOffset(CGPoint(x: view.bounds.width, y: 0), animated: true)
    updateBarButtons()
  }
}
