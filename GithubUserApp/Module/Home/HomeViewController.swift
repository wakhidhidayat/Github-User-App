//
//  HomeViewController.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usersTable: UITableView!
    
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.register(
            HomeTableViewCell.nib(),
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        usersTable.dataSource = self
        usersTable.rowHeight = 120
        
        homeActivityIndicator.startAnimating()
        
        let presenter = HomePresenter(useCase: Injection().provideHome())
        presenter.getUsers { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.homeActivityIndicator.stopAnimating()
                    self.users = value
                    self.usersTable.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.homeActivityIndicator.stopAnimating()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeTableViewCell.identifier,
            for: indexPath
        ) as? HomeTableViewCell
        cell?.configure(with: users[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120.0)
    }
    
}
