//
//  HomeTableViewCell.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    static let identifier = "HomeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.borderWidth = 1
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.borderColor = UIColor.black.cgColor
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with user: UserModel) {
        if let imageUrl = URL(string: user.avatarUrl) {
            avatarImage.kf.indicatorType = .activity
            avatarImage.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2))])
        }
        
        usernameLabel.text = user.username
    }
}
