//
//  ActionLabelView.swift
//  Spotify
//
//  Created by 이건준 on 2023/04/19.
//

import UIKit

struct ActionLabelViewViewModel {
  let text: String
  let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject {
  func actionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView {
  
  weak var delegate: ActionLabelViewDelegate?
  
  private let label: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .secondaryLabel
    return label
  }()
  
  private let button: UIButton = {
    let button = UIButton()
    button.setTitleColor(.link, for: .normal)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    clipsToBounds = true
    isHidden = true
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
    button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: self.bounds.height - 45).isActive = true
  }
  
  @objc func didTapButton() {
    delegate?.actionLabelViewDidTapButton(self)
  }
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    button.frame = CGRect(x: 0, y: height-40, width: width, height: 40)
//    label.frame = CGRect(x: 0, y: 0, width: width, height: height-45)
//  }
  
  func configureUI(with viewModel: ActionLabelViewViewModel) {
    label.text = viewModel.text
    button.setTitle(viewModel.actionTitle, for: .normal)
  }
}

