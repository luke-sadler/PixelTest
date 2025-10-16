//
//  UserTableViewModel.swift
//  PixelTestUIKit
//
//  Created by luke on 15/10/2025.
//

import Foundation
import UIKit

protocol UserTableViewModelDelegate: NSObject {
  func userTableViewModelRequestsTableReloadCell(_ cell: UITableViewCell)
}

class UserTableViewModel: NSObject {
  
  // MARK: - Injected values
  @Injected(\.userFetchServiceProvider) private var userFetchingService: UserFetchService
  @Injected(\.accountManagementServiceProvider) private var accountManagementService: AccountManagementService

  // MARK: - Public vars
  var followedUsers = [Int]()
  var users = [User]()
  weak var delegate: UserTableViewModelDelegate?
  
  // MARK: - Constructor
  override init() {
    super.init()
    
    InjectedValues[\.userFetchServiceProvider] = UserFetchServiceMock()
  }
  
  // MARK: - Public functions
  func loadUserData() async throws {
    users = try await userFetchingService.fetchTopUserList()
    followedUsers = try await accountManagementService.fetchFollowedUsers()
  }
  
}

// MARK: - Table data source functions
extension UserTableViewModel: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let user = users[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell",
                                             for: indexPath) as? UserTableViewCell ?? UserTableViewCell()
    
    cell.delegate = self
    cell.setupUserView(user)
    return cell
  }
}

// MARK: - Table cell delegate methods
extension UserTableViewModel: UserTableViewCellDelegate {
  
  func userTableViewCellQueryUserFollow(_ userId: Int) -> Bool {
    followedUsers.contains(userId)
  }
  
  func userTableViewCellTappedFollowButton(_ cell: UITableViewCell, _ userId: Int) async throws {
    
    if followedUsers.contains(userId) {
      try await accountManagementService.unfollowUser(userId)
    } else {
      try await accountManagementService.followUser(userId)
    }
    
    followedUsers = try await accountManagementService.fetchFollowedUsers()
    
    delegate?.userTableViewModelRequestsTableReloadCell(cell)
  }
  
  func userTableViewCellRequestsProfileImage(for userId: Int) async throws -> UIImage {
    guard let user = users.first(where: { $0.accountId == userId }) else {
      throw UserTableViewCellError.unknown
    }
    
    let imageData = try await userFetchingService.fetchUserProfileImage(user)
    
    if let image = UIImage(data: imageData) {
      return image
    } else {
      throw UserTableViewCellError.imageDataFailed
    }
    
  }
}
