//
//  TableCell.swift
//  map
//
//  Created by Evgeni' Roslik on 20/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    
    @IBOutlet var city: UILabel!
    @IBOutlet var temp: UILabel!
    
    @IBOutlet var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
