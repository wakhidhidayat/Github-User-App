//
//  FavoriteTableViewCell.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 22/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let identifier = "FavoriteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.toCircleImage()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with user: DetailUserModel) {
        if let imageUrl = URL(string: user.avatarUrl) {
            avatarImage.kf.indicatorType = .activity
            avatarImage.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2))])
        }
        usernameLabel.text = user.username
    }
    
}
