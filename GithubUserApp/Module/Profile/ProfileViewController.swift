//
//  ProfileViewController.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 24/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.toCircleImage()
    }

}
