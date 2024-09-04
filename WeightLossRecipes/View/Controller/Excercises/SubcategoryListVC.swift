//
//  ExerciseListVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 14/11/2023.
//

import UIKit
import Alamofire
import Kingfisher
import GoogleMobileAds
class SubcategoryListVC: UIViewController, GADBannerViewDelegate {

    var exerciseList = [ExListInfoModel]()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var bannerView: GADBannerView!
    var tempImage : UIImage!
    var exerciseNumber: String!
    var catId: String!
    var exName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        print(exerciseNumber)

        indicator.startAnimating()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        exSubCatListApi()
        
    }

    func exSubCatListApi()
    {
        
        let exViewModel = ExercisesViewModal()
        
        exViewModel.GetExListApi { response in
            
            if response.status == "success"
            {
                print(response.type)
                
                for type in response.type
                {
                    let categoryId = type.id
                    for cat in type.category
                    {
                        
                        let name = cat.title
                        if categoryId == Int(self.catId) && name == self.exerciseNumber
                        {
                            let subcategories = cat.subcategory
                            for subcategory in subcategories {
                                // Access individual subcategory properties here
                                
                                let infoModal = ExListInfoModel(ex_id: subcategory.id, ex_title: subcategory.title, ex_image: subcategory.wallpaperImage, ex_gif: subcategory.wallpaperGIF, ex_url: subcategory.wallpaperImageURL)
                                self.exerciseList.append(infoModal)
                                
                                // ... access other subcategory properties as needed
                            }
                            
                        }
                        
                    }
                    self.collectionView.reloadData()
                    self.indicator.stopAnimating()
                    
                }
                //let catType = response.type.first
                //let categoryId = catType!.category.first?.categoryID
                
            }
        } onFailure: { error in
            
            print(error)
          
        }
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension SubcategoryListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        var width: CGFloat = 0.0

        if UIScreen.main.bounds.width == 414 { // iPhone XS Max screen width
            width = (frame.size.width - 30) / 2.0 // Adjusted width for iPhone XS Max
        } else {
            width = (frame.size.width - 10) / 2.0 // Original width calculation for other iPhones
        }

        var height = width
       
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exerciseList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.indicator.startAnimating()
        let value = exerciseList[indexPath.row]
        
        cell.lbl_title.text = value.ex_title
        
        
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(exBaseImageURL)\(value.ex_image!)"
        
        if let encodedUrlString = imageUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedUrlString) {
            
            // this downloads the image asynchronously if it's not cached yet
           cell.thumbnail.kf.setImage(with: url)
            cell.indicator.stopAnimating()
        } else {
            print("Invalid URL: \(imageUrlString)")
        }
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayGif") as! PlayGif
        
        let value = exerciseList[indexPath.row]
        
        let imageGif = "\(exBaseImageURL)\(value.ex_image!)"
        
         let encodedImgUrlString = imageGif.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
        let imageUrlString = "\(exBaseImageURL)\(value.ex_gif!)"
      
        let encodedUrlString = imageUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
            vc.gifUrl = encodedUrlString
            vc.ImgGifUrl = encodedImgUrlString
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
