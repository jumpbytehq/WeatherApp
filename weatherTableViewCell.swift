//
//  weatherTableViewCell.swift
//  Weather
//
//  Created by Ankur Jain on 30/04/16.
//  Copyright © 2016 Tanisha. All rights reserved.
//

import UIKit

class weatherTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var condition: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
