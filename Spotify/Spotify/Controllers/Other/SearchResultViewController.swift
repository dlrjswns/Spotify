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

class SearchResultViewController: UIViewController {
    
    private var results: [[SearchSection]] = []
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
                case .artist: true
                default: return false
            }
        })
        self.results = [
            SearchSection(title: "Artists", results: artists)
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
