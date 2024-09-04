//
//  ExcercisesCategoriesVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/10/2023.
//

import UIKit
import GoogleMobileAds

class ExercisesVC: UIViewController, GADBannerViewDelegate {

    var catArray = [ExcercisesCatInfoModal]()
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        
       var info = ExcercisesCatInfoModal(title: "Men's Fitness Workout Exercises", gif_name: "charector")
        catArray.append(info)
        
        info = ExcercisesCatInfoModal(title: "Women's Fitness Workout Exercises", gif_name: "charector_girl")
         catArray.append(info)
        
       // info = ExcercisesCatInfoModal(title: "Yoga Fitness Workout Exercises", gif_name: "charector")
         //catArray.append(info)
        collectionView.reloadData()
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ExercisesVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        let info = catArray[indexPath.row]
        cell.lbl_title.text = info.title
        cell.thumbnail.image = UIImage(named: info.gif_name)
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubcategoriesVC") as! SubcategoriesVC
        if indexPath.row == 0{
            vc.catId = "39"
        }else if indexPath.row == 1
        {
            vc.catId = "40"
        }
     
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
