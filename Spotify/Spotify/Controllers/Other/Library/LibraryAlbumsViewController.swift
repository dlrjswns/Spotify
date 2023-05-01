//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by 이건준 on 2023/04/30.
//

import UIKit

final class LibraryAlbumsViewController: UIViewController {
  
  var albums = [Album]()
  
  private let noAlbumsView = ActionLabelView()
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(
      SearchResultSubtitleTableViewCell.self,
      forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identfier)
    tableView.isHidden = true
    return tableView
  }()
  
  private var observer: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    setUpNoAlbumsView()
    fetchData()
    observer = NotificationCenter.default.addObserver(
      forName: .albumSavedNotification,
      object: nil,
      queue: .main,
      using: { [weak self] _ in
        self?.fetchData()
      }
    )
  }
  
  @objc func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
  
  private func setUpNoAlbumsView() {
    view.addSubview(noAlbumsView)
    noAlbumsView.translatesAutoresizingMaskIntoConstraints = false
    noAlbumsView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    noAlbumsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    noAlbumsView.delegate = self
    noAlbumsView.configureUI(
      with: ActionLabelViewViewModel(
        text: "You have not saved any albums yet.",
        actionTitle: "Browse"
      )
    )
  }
  
  private func fetchData() {
    albums.removeAll()
    APICaller.shared.getCurrentUserAlbums { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let albums):
          self?.albums = albums
          self?.updateUI()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  private func updateUI() {
    if albums.isEmpty {
      // Show label
      noAlbumsView.isHidden = false
      tableView.isHidden = true
    }
    else {
      // Show table
      tableView.reloadData()
      noAlbumsView.isHidden = true
      tableView.isHidden = false
    }
  }
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
  func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
    tabBarController?.selectedIndex = 0
  }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: SearchResultSubtitleTableViewCell.identfier,
      for: indexPath
    ) as? SearchResultSubtitleTableViewCell else {
      return UITableViewCell()
    }
    let album = albums[indexPath.row]
    cell.configureUI(
      with: SearchResultSubtitleTableViewCellViewModel(
        title: album.name,
        subtitle: album.artists.first?.name ?? "-",
        imageURL: URL(string: album.images.first?.url ?? "")
      )
    )
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    HapticsManager.shared.vibrateForSelection()
    let album = albums[indexPath.row]
    let vc = AlbumViewController(album: album)
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
}

