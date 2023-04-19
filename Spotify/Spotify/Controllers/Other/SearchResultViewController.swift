//
//  SearchResultViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var sections: [SearchSection] = []
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identfier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
                case .artist: return true
                default: return false
            }
        })
        
        let albums = results.filter({
            switch $0 {
                case .album: return true
                default: return false
            }
        })
        
        let tracks = results.filter({
            switch $0 {
                case .track: return true
                default: return false
            }
        })
        
        let playlists = results.filter({
            switch $0 {
                case .playlist: return true
                default: return false
            }
        })
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums),
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch result {
            case .artist(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultDefaultTableViewCell.identifier, for: indexPath) as? SearchResultDefaultTableViewCell ?? SearchResultDefaultTableViewCell()
                let viewModel = SearchResultDefaultTableViewCellViewModel(title: model.name, imageURL: URL(string: model.images?.first?.url ?? ""))
                cell.configureUI(with: viewModel)
            case .track(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identfier, for: indexPath) as? SearchResultSubtitleTableViewCell ?? SearchResultSubtitleTableViewCell()
          let viewModel = SearchResultSubtitleTableViewCellViewModel(
            title: model.name,
            subtitle: model.artists.first?.name ?? "-",
            imageURL: URL(string: model.album?.images.first?.url ?? "")
          )
                cell.configureUI(with: viewModel)
            case .album(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identfier, for: indexPath) as? SearchResultSubtitleTableViewCell ?? SearchResultSubtitleTableViewCell()
          let viewModel = SearchResultSubtitleTableViewCellViewModel(title: model.name, subtitle: "", imageURL: URL(string: model.images.first?.url ?? ""))
                cell.configureUI(with: viewModel)
            case .playlist(let model):
                cell.textLabel?.text = model.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
}
