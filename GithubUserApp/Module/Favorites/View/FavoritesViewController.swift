//
//  FavoritesViewController.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 22/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import RxSwift

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    private var favorites = [DetailUserModel]()
    private let favoritePresenter = FavoritePresenter(useCase: Injection().provideFavorites())
    private let favoriteRouter = FavoriteRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesTable.register(
            FavoriteTableViewCell.nib(),
            forCellReuseIdentifier: FavoriteTableViewCell.identifier
        )
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        favoritesTable.rowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.startAnimating()
        
        favoritePresenter.getFavorites()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.favorites = result
            } onError: { error in
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            } onCompleted: {
                DispatchQueue.main.async {
                    self.favoritesTable.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }.disposed(by: disposeBag)
    }

}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteTableViewCell.identifier,
            for: indexPath
        ) as? FavoriteTableViewCell
        cell?.configure(with: favorites[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        favoriteRouter.moveToDetail(
            username: favorites[indexPath.row].username,
            navigationController: navigationController
        )
    }
    
}
