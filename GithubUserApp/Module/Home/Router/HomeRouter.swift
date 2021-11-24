//
//  HomeRouter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class HomeRouter {
    
    func moveToDetail(username: String, navigationController: UINavigationController?, isInFavorites: Bool) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.username = username
        detailVC.isInFavorites = isInFavorites
        detailVC.presenter = DetailUserPresenter(useCase: Injection().provideDetailUser())
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
