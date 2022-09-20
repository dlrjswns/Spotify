//
//  HomeViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

enum BrowseSectionType {
    case newReleases([NewReleasesCellViewModel])
    case featuredPlaylists([FeaturedPlaylistCellViewModel])
    case recommendedTracks([RecommendedTrackCellViewModel])
    
    var title: String {
        switch self {
            case .newReleases(_):
                return "New Released Albums"
            case .featuredPlaylists(_):
                return "Featured Playlists"
            case .recommendedTracks(_):
                return "Recommended"
        }
    }
}

class HomeViewController: UIViewController {
    
    private var newAlbums: [Album] = []
    private var playlists: [Playlist] = []
    private var tracks: [AudioTrack] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sec, env -> NSCollectionLayoutSection? in
            return Self.createSectionLayout(sectionIndex: sec)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private var sections = [BrowseSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTappedSettings))
        configureUI()
        setCollectionView(collectionView)
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureUI() {
        _ = [collectionView, spinner].map{ ui in
            view.addSubview(ui)
            ui.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private static func createSectionLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        switch sectionIndex {
            case 0:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )

                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                // Vertical group in horizontal group
                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(390)
                    ),
                    subitem: item,
                    count: 3
                )

                let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .absolute(390)
                    ),
                    subitem: verticalGroup,
                    count: 1
                )

                // Section
                let section = NSCollectionLayoutSection(group: horizontalGroup)
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = supplementaryViews
                return section
            case 1:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(200)
                    )
                )

                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(400)
                    ),
                    subitem: item,
                    count: 2
                )

                let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(400)
                    ),
                    subitem: verticalGroup,
                    count: 1
                )

                // Section
                let section = NSCollectionLayoutSection(group: horizontalGroup)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = supplementaryViews
                return section
            case 2:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )

                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(80)
                    ),
                    subitem: item,
                    count: 1
                )

                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = supplementaryViews
                return section
            default:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )

                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(390)
                    ),
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = supplementaryViews
                return section
            }
        }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlaylistsResponse?
        var recommendations: RecommendationsResponse?

        // New Releases
        APICaller.shared.getNewReleases { result in
            defer {
                print("ASdfasdf?")
                group.leave()
            }
            switch result {
            case .success(let model):
                print("뭐임 = \(model)")
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // Featured Playlists
        APICaller.shared.getFeaturedPlayLists { result in
            defer {
                group.leave()
            }

            switch result {
            case .success(let model):
                print("model12 = \(model)")
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)

            }
        }

        // Recommended Tracks
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }

                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }

                    switch recommendedResult {
                    case .success(let model):
                        print("model = \(model)")
                        recommendations = model

                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {
                fatalError("Models are nil")
            }
            print("시발?")
            self.configureModels(
                newAlbums: newAlbums,
                playlists: playlists,
                tracks: tracks
            )
        }
    }
    
    private func configureModels(
            newAlbums: [Album],
            playlists: [Playlist],
            tracks: [AudioTrack]
        ) {
            self.newAlbums = newAlbums
            self.playlists = playlists
            self.tracks = tracks
            sections.append(.newReleases(newAlbums.compactMap({
                return NewReleasesCellViewModel(
                    name: $0.name,
                    artworkURL: URL(string: $0.images.first?.url ?? ""),
                    numberOfTracks: $0.total_tracks,
                    artistName: $0.artists.first?.name ?? "-"
                )
            })))

            sections.append(.featuredPlaylists(playlists.compactMap({
                return FeaturedPlaylistCellViewModel(
                    name: $0.name,
                    artworkURL: URL(string: $0.images.first?.url ?? ""),
                    creatorName: $0.owner.display_name
                )
            })))

            sections.append(.recommendedTracks(tracks.compactMap({
                return RecommendedTrackCellViewModel(
                    name: $0.name,
                    artistName: $0.artists.first?.name ?? "-",
                    artworkURL: URL(string: $0.album?.images.first?.url ?? "")
                )
            })))

            collectionView.reloadData()
        }
    
    @objc func didTappedSettings() {
        let vc = SettingViewController()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
            case .newReleases(let viewModels):
                return viewModels.count
            case .featuredPlaylists(let viewModels):
                return viewModels.count
            case .recommendedTracks(let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        switch section {
            case .newReleases:
                let album = newAlbums[indexPath.row]
                let vc = AlbumViewController(album: album)
                vc.title = album.name
                vc.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.pushViewController(vc, animated: true)
            case .recommendedTracks(let viewModels):
                break
            case .featuredPlaylists:
                let playList = playlists[indexPath.row]
                let vc = PlaylistViewController(playList: playList)
                vc.title = playList.name
                vc.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = sections[indexPath.section]
        switch type {
        case .newReleases(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell ?? NewReleaseCollectionViewCell()
            let viewModel = viewModels[indexPath.row]
            cell.configureUI(with: viewModel)
            
            return cell
        case .featuredPlaylists(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell ?? FeaturedPlaylistCollectionViewCell()
            let viewModel = viewModels[indexPath.row]
            cell.configureUI(with: viewModel)
            return cell
        case .recommendedTracks(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell ?? RecommendedTrackCollectionViewCell()
            cell.backgroundColor = .orange
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView ?? TitleHeaderCollectionReusableView()
        let section = indexPath.section
        let title = sections[section].title
        header.configureUI(with: title)
        return header
    }
}
