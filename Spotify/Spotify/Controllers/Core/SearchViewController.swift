//
//  SearchViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController: UISearchController = {
//        let results = UIViewController()
//        results.view.backgroundColor = .red
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 2,
                    leading: 7,
                    bottom: 2,
                    trailing: 7
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(150)),
                    subitem: item,
                    count: 2
                )

                group.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 0,
                    bottom: 10,
                    trailing: 0
                )

                return NSCollectionLayoutSection(group: group)
            })
        )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchResultsController = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell ?? GenreCollectionViewCell()
        cell.configureUI(with: "Rock")
        return cell
    }
}
