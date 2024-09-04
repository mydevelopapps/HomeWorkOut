//
//  HomeTableViewCell.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 18/09/2023.
//

import UIKit
import WebKit
class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_review: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
