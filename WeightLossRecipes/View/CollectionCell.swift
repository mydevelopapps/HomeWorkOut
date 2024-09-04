//
//  CollectionCell.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 20/09/2023.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var lbl_exNumber: UILabel!
    @IBOutlet var lbl_review: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var bg_view: UIView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var  pageControl:UIPageControl!
}
