//
//  PostCell.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/28/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
