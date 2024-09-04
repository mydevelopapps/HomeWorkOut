//
//  SideMenuTableViewCell.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 18/09/2023.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet var lbl_userName: UILabel!
    @IBOutlet var img_profile: UIImageView!
    
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var img_options: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
