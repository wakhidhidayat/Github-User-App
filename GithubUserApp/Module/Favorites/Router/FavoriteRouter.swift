//
//  FavoriteRouter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 24/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class FavoriteRouter {
    
    func moveToDetail(username: String, navigationController: UINavigationController?) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.username = username
        detailVC.isInFavorites = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
