//
//  ProductTableViewCell.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var borderImage: UIView!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    @IBOutlet weak var imageProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderImage.layer.borderWidth = 1
        self.borderImage.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
