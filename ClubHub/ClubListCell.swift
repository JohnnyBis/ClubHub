//
//  ClubListCell.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 2/3/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit

class ClubListCell: UITableViewCell {

    @IBOutlet weak var clubProfileImage: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clubName.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
