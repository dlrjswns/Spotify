//
//  CagetoryViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/09/24.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private let category: Category
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sec, env -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140)), subitem: item, count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            return NSCollectionLayoutSection(group: group)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    private var playlists = [Playlist]()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        APICaller.shared.getCategoryPlaylists(category: category) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                case .failure(let error): break
                case .success(let playlists):
                    self.playlists = playlists
                    self.collectionView.reloadData()
            }
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
            for: indexPath
        ) as? FeaturedPlaylistCollectionViewCell ?? FeaturedPlaylistCollectionViewCell()
        let playlist = playlists[indexPath.row]
        cell.configureUI(with: FeaturedPlaylistCellViewModel(name: playlist.name,
                                                             artworkURL: URL(string: playlist.images.first?.url ?? ""),
                                                             creatorName: playlist.owner.display_name))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlaylistViewController(playList: playlists[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
