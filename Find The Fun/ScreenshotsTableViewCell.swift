//
//  ScreenshotsTableViewCell.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 31/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import UIKit

class ScreenshotsTableViewCell: UITableViewCell {

    @IBOutlet weak var screenshots: UILabel?
    
    static var screenshotsTableViewCellIdentifier: String { return "ScreenshotsTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
