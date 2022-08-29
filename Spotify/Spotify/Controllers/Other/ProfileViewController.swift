//
//  ProfileViewController.swift
//  Spotify
//
//  Created by 이건준 on 2022/08/26.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
                case .success(let model):
                    print("model = \(model)")
                    break
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
