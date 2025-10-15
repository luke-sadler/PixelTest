//
//  UserTableViewCell.swift
//  PixelTestUIKit
//
//  Created by luke on 15/10/2025.
//

import Foundation
import UIKit

protocol UserTableViewCellDelegate: NSObject {
  func userTableViewCellQueryUserFollow(_ userId: Int) -> Bool
  func userTableViewCellTappedFollowButton(_ cell: UITableViewCell, _ userId: Int) async throws
  func userTableViewCellRequestsProfileImage(for userId: Int) async throws -> UIImage
}

enum UserTableViewCellError: Error {
  case imageDataFailed
  case unknown
}

class UserTableViewCell: UITableViewCell {
  
  @IBOutlet var profileImageActivityView: UIActivityIndicatorView!
  @IBOutlet var profileImageView: UIImageView!
  
  // Jon Skeet
  @IBOutlet var usernameLabel: UILabel!
  // Created on:
  @IBOutlet var createdOnLabel: UILabel!
  // 01/10/20
  @IBOutlet var createdDateLabel: UILabel!
  // Heart or not
  @IBOutlet var followButton: UIButton!
  
  weak var delegate: UserTableViewCellDelegate?
  
  private var userId: Int?
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  private func setupUI() {
    self.selectionStyle = .none
    
    profileImageView.clipsToBounds = true
    profileImageView.layer.cornerRadius = 15
    
    profileImageActivityView.hidesWhenStopped = true
    
    usernameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    createdOnLabel.text = "Created on:"
    createdDateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    usernameLabel.adjustsFontForContentSizeCategory = true
    createdOnLabel.adjustsFontForContentSizeCategory = true
    createdDateLabel.adjustsFontForContentSizeCategory = true
    
    followButton.tintColor = .red
  }
  
  func setupUserView(_ user: User) {
    self.userId = user.accountId
    
    self.usernameLabel.text = user.presentableDisplayName
    self.createdDateLabel.text = user.presentableCreationDate
    
    if delegate?.userTableViewCellQueryUserFollow(user.accountId) == true {
      followButton.setImage(
        UIImage(systemName: "heart.fill"),
        for: .normal
      )
    } else {
      followButton.setImage(
        UIImage(systemName: "heart"),
        for: .normal
      )
    }
    
    handleProfileImage(user.accountId)
  }
  
  private func handleProfileImage(_ id: Int) {

    profileImageView.image = nil
    profileImageActivityView.startAnimating()
    
    Task {
      do {
        let image = try await delegate?.userTableViewCellRequestsProfileImage(for: id)
        profileImageView.image = image
      } catch let error {
        print("image loading error: \(error)")
      }
      
      profileImageActivityView.stopAnimating()
    }
  }
  
  @IBAction func followButtonTapped(_ sender: UIButton) {
    guard let userId else { return }
    
    Task {
      do {
        try await delegate?.userTableViewCellTappedFollowButton(self, userId)
      } catch let error {
        print("follow error: \(error)")
      }
    }
  }
  
  
  
}
