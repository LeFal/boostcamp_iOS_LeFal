//
//  ItemCell.swift
//  week3_homepwner
//
//  Created by LEOFALCON on 2017. 7. 18..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ItemCell : UITableViewCell {
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var serialNumberLabel : UILabel!
    @IBOutlet var valueLabel : UILabel!

    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = caption1Font
    }

}
