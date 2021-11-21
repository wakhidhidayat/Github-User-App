//
//  HomeRouter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class HomeRouter {
    
    func moveToDetail(username: String, navigationController: UINavigationController?) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.username = username
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
