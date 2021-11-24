//
//  DetailViewController.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var repositoryLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var detailActivityIndicator: UIImageView!
    
    private let disposeBag = DisposeBag()
    private var user: DetailUserModel?
    var presenter: DetailUserPresenterProtocol!
    var username = ""
    var isInFavorites = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.toCircleImage()
        avatarImage.kf.indicatorType = .activity
        
        detailActivityIndicator.startAnimating()
        
        presenter.getDetailUser(username: username)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.user = result
            } onError: { error in
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.detailActivityIndicator.stopAnimating()
                }
            } onCompleted: {
                DispatchQueue.main.async {
                    if let user = self.user {
                        self.avatarImage.kf.setImage(
                            with: URL(string: user.avatarUrl),
                            options: [.transition(.fade(0.2))]
                        )
                        self.repositoryLabel.text = String(user.repos)
                        self.followersLabel.text = String(user.followers)
                        self.followingLabel.text = String(user.following)
                        self.locationLabel.text = user.location ?? "Unknown"
                        self.emailLabel.text = user.email ?? "Unknown"
                        self.detailActivityIndicator.stopAnimating()
                        
                        if self.isInFavorites {
                            self.setButtonRemoveFromFavorites()
                        } else {
                            self.setButtonAddToFavorites()
                        }
                    }
                }
            }.disposed(by: disposeBag)
    }
    
    @objc private func addToFavorites() {
        if let user = user {
            presenter.addToFavorites(user: user)
                .observe(on: MainScheduler.instance)
                .subscribe { result in
                    print(result)
                } onError: { error in
                    print(error.localizedDescription)
                } onCompleted: {
                    self.isInFavorites = true
                    self.setButtonRemoveFromFavorites()
                    self.present(
                        Alert.basicAlert(title: "Added to favorites", message: nil),
                        animated: true,
                        completion: nil
                    )
                }.disposed(by: disposeBag)
        }
    }
    
    @objc private func removeFromFavorites(userId: Int) {
        if let user = user {
            presenter.deleteUser(user: user)
                .observe(on: MainScheduler.instance)
                .subscribe { result in
                    print(result)
                } onError: { error in
                    print(error.localizedDescription)
                } onCompleted: {
                    self.isInFavorites = false
                    self.setButtonAddToFavorites()
                    self.present(
                        Alert.basicAlert(title: "Removed from favorites", message: nil),
                        animated: true,
                        completion: nil
                    )
                }.disposed(by: disposeBag)
        }
    }
    
    private func setButtonAddToFavorites() {
        let addToFavoritesButton = UIBarButtonItem(
            image: UIImage(systemName: "suit.heart"), style: .plain,
            target: self, action: #selector(self.addToFavorites)
        )
        self.navigationItem.rightBarButtonItem = addToFavoritesButton
    }
    
    private func setButtonRemoveFromFavorites() {
        let removeFromFavoritesButton = UIBarButtonItem(
            image: UIImage(systemName: "suit.heart.fill"),
            style: .plain, target: self, action: #selector(self.removeFromFavorites)
        )
        self.navigationItem.rightBarButtonItem = removeFromFavoritesButton
    }
    
}
