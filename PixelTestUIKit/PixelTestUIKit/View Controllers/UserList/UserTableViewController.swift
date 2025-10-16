//
//  ViewController.swift
//  PixelTestUIKit
//
//  Created by luke on 15/10/2025.
//

import UIKit
import SnapKit

class UserTableViewController: UITableViewController {
  
  let viewModel = UserTableViewModel()
  let activityIndicator = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    viewModel.delegate = self
    
    setupTable()
    setupActivityIndicator()
    populateData()
  }
  
  func setupTable() {
    
    tableView.register(
      .init(nibName: "UserTableViewCell", bundle: nil),
      forCellReuseIdentifier: "UserCell")
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    
    self.tableView.dataSource = viewModel
  }
  
  func setupActivityIndicator() {
    
    view.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    activityIndicator.hidesWhenStopped = true
  }
  
  func showError(_ error: Error) {
    let alert = UIAlertController(title: "An Error Occurred",
                                  message: error.localizedDescription,
                                  preferredStyle: .alert)
    self.present(alert, animated: true)
  }
  
  func populateData() {
    activityIndicator.startAnimating()
    
    Task {
      do {
        
        try await viewModel.loadUserData()
        self.tableView.reloadData()
        
      } catch let error {
        showError(error)
      }
    }
    
    activityIndicator.stopAnimating()
    
  }
}

extension UserTableViewController: UserTableViewModelDelegate {
  
  func userTableViewModelRequestsTableReloadCell(_ cell: UITableViewCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      self.tableView.reloadRows(at: [indexPath], with: .none)
    }
  }
  
}
