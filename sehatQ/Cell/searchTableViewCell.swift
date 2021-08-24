//
//  searchTableViewCell.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var priceSearch: UILabel!
    @IBOutlet weak var titleSearch: UILabel!
    @IBOutlet weak var imageSearch: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
