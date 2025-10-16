//
//  UserBadgesView.swift
//  PixelTestUIKit
//
//  Created by luke on 16/10/2025.
//

import Foundation
import UIKit

class UserBadgesView: UIView {
  
  // MARK: - Private components
  private var goldLabel: UILabel!
  private var silverLabel: UILabel!
  private var bronzeLabel: UILabel!
  private var hStack: UIStackView!
  
  // MARK: - Constructor
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - Private functions
  private func setupView() {
    setupStackView()
    setupBadges()
  }
  
  private func setupStackView() {
    
    hStack = .init()
    hStack.axis = .horizontal
    hStack.alignment = .center
    hStack.spacing = 8
    
    self.addSubview(hStack)
    
    hStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      hStack.topAnchor.constraint(equalTo: self.topAnchor),
      hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  private func circleView(_ colour: UIColor) -> UIView {
    let circle = UIView()
    circle.layer.cornerRadius = 5
    circle.layer.masksToBounds = true
    circle.backgroundColor = colour
    
    circle.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      circle.widthAnchor.constraint(equalToConstant: 10),
      circle.heightAnchor.constraint(equalToConstant: 10)
    ])
    
    return circle
  }
  
  private func setupBadges() {
    
    goldLabel = .init()
    silverLabel = .init()
    bronzeLabel = .init()
    
    hStack.addArrangedSubview(circleView(.yellow))
    hStack.addArrangedSubview(goldLabel)
    
    hStack.addArrangedSubview(circleView(.gray))
    hStack.addArrangedSubview(silverLabel)
    
    hStack.addArrangedSubview(circleView(.brown))
    hStack.addArrangedSubview(bronzeLabel)
  }
  
  // MARK: - Public functions
  func updateBadgeValues(_ badges: UserBadges) {
    goldLabel.text = "\(badges.gold)"
    silverLabel.text = "\(badges.silver)"
    bronzeLabel.text = "\(badges.bronze)"
  }
}
