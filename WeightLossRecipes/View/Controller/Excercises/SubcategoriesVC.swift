//
//  ExcercisesVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/10/2023.
//

import UIKit
import Alamofire
import GoogleMobileAds
class SubcategoriesVC: UIViewController, GADBannerViewDelegate {

    var exerciseList = [ExSubCatInfoModel]()
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    var tempImage : UIImage!
    var catId: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        indicator.startAnimating()
        exSubCatApi()
    }

    func exSubCatApi()
    {
        
        let exViewModel = ExercisesViewModal()
        
        exViewModel.GetExSubCategoryApi { response in
            
            if response.status == "success"
            {
                print(response.data)
                
                for data in response.data
                {

                    if data.categoryID == self.catId{
                        
                        let subCatInfo = ExSubCatInfoModel(category_id: data.categoryID, image_link: data.imageLink)

                        self.exerciseList.append(subCatInfo)
                        
                    }
                  
                    self.collectionView.reloadData()
                    self.indicator.stopAnimating()
                }

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

extension SubcategoriesVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exerciseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        var width: CGFloat = 0.0
        
        width = UIScreen.main.bounds.width
        
        var height = width
        if self.tempImage != nil {
            let ratio = self.tempImage.size.height / self.tempImage.size.width
            height = ratio * width
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        let info = exerciseList[indexPath.row]
        if catId == "40"
        {
            cell.lbl_title.text = "Women's Fitness                  Workout Excercises  "
        }
        cell.indicator.startAnimating()
        
        cell.lbl_exNumber.text = String(indexPath.row + 1)
          
                // Use Alamofire to download the image data
                AF.request(info.image_link!).responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Create a UIImage from the downloaded data
                        if let image = UIImage(data: data) {
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                // Set the downloaded image to the UIImageView
                                if image != nil && self.tempImage == nil {
                                    self.tempImage = image
                                    self.collectionView.reloadData()
                                }
                                cell.thumbnail.image = image
                               cell.indicator.stopAnimating()
                            }
                        }
                    case .failure(let error):
                        // Handle the error, e.g., show a placeholder image
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
        cell.bg_view.layer.cornerRadius = 8
        cell.bg_view.layer.masksToBounds = true
        return cell
    }   
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubcategoryListVC") as! SubcategoryListVC
        vc.exerciseNumber = "Exercise \(indexPath.row+1)"
        
        vc.catId = self.catId

        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
