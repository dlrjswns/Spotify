//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

class PlaylistViewController: UIViewController {
    private let playList: Playlist
    
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewCompositionalLayout(
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()
    
    init(playList: Playlist) {
        self.playList = playList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playList.name
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getPlaylistDetails(for: playList) { result in
            switch result {
                case .success(let model):
                    print("model = \(model)")
                case .failure(let error):
                    print("getPlaylistDetails error occured = \(error.localizedDescription)")
            }
        }
    }
}
