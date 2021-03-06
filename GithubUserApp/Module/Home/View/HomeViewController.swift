//
//  HomeViewController.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usersTable: UITableView!
    
    private let disposeBag = DisposeBag()
    private let homeRouter = HomeRouter()
    var presenter: HomePresenterProtocol!
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.register(
            HomeTableViewCell.nib(),
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        usersTable.dataSource = self
        usersTable.rowHeight = 120
        usersTable.delegate = self
        
        homeActivityIndicator.startAnimating()
        
        presenter.getUsers()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.users = result
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                DispatchQueue.main.async {
                    self.usersTable.reloadData()
                    self.homeActivityIndicator.stopAnimating()
                }
            }.disposed(by: disposeBag)
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

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var isInFavorites = false
        presenter.checkUserIsInFavorites(userId: users[indexPath.row].id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                isInFavorites = result
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                print(isInFavorites)
            }.disposed(by: disposeBag)
        
        homeRouter.moveToDetail(
            username: users[indexPath.row].username,
            navigationController: navigationController,
            isInFavorites: isInFavorites
        )
    }
    
}
