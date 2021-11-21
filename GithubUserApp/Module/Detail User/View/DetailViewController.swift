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
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImage.toCircleImage()
        avatarImage.kf.indicatorType = .activity
        
        let presenter = DetailUserPresenter(
            useCase: Injection().provideDetailUser()
        )
        
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
                    }
                }
            }.disposed(by: disposeBag)
    }
    
}
