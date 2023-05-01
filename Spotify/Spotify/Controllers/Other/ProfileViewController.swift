//
//  ProfileViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import SDWebImage
import UIKit

final class ProfileViewController: UIViewController {
    
    private var models = [String]()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setTableView(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.updateUI(with: model)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.failedToGetProfile()
                    }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel()
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        label.layoutIfNeeded()
    }
    
    class ProfileHeaderView: UIView {
        
        private let imageView: UIImageView = {
           let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 40
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
//            imageView.layer.masksToBounds = true
//            imageView.layer.cornerRadius =
        }
        
        public func configureUI(with url: URL) {
            imageView.sd_setImage(with: url)
        }
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string,
              let url = URL(string: urlString) else { return }
        
        let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width / 1.5))
        profileHeaderView.configureUI(with: url)
        tableView.tableHeaderView = profileHeaderView
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
}
