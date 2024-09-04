//
//  FavouriteVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 23/09/2023.
//

import UIKit
import Alamofire
import GoogleMobileAds
class FavouriteVC: UIViewController, GADBannerViewDelegate {

    var favRecipes = [FavInfoModel]()
    var tempImage : UIImage!
   @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        self.indicator.startAnimating()
        self.collectionView.isHidden = true
        getFavRecipeApi()
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getFavRecipeApi()
    {
        
        let favViewModel = FavouriteViewModel()
        
        favViewModel.GetFavRecipeApi { response in
            
            if response.success == "true"
            {
                print(response.recipes)
                
                for recipe in response.recipes
                {
                    let favInfo = FavInfoModel(id: recipe.id, premium: recipe.premium, title: recipe.title, image_thumbnail: recipe.image, ingrediants: recipe.ingredients, instructions: recipe.instructions)
                    
                    self.favRecipes.append(favInfo)
                    
                }
                
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
                self.collectionView.isHidden = false
            }
        } onFailure: { error in
            
            print(error)
            self.showAlertAction(message: error)
        }

    }

    func showAlertAction(message: String)
    {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

     
        let confirmAction = UIAlertAction(
            title: "OK", style: UIAlertAction.Style.default) { (action) in
              
            // ...
        }

        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension FavouriteVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        let recipe = favRecipes[indexPath.row]
        
        cell.indicator.startAnimating()
        cell.lbl_title.text = recipe.title
        
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(baseImageURL)\(recipe.image_thumbnail!)"

                // Use Alamofire to download the image data
                AF.request(imageUrlString).responseData { response in
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
        
        cell.layer.cornerRadius = 8.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let recipe = favRecipes[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.infoObj = String(recipe.id!)
        vc.isFromFavList = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

extension FavouriteVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        var width: CGFloat = 0.0

        if UIScreen.main.bounds.width == 414 { // iPhone XS Max screen width
            width = (frame.size.width - 30) / 2.0 // Adjusted width for iPhone XS Max
        } else {
            width = (frame.size.width - 10) / 2.0 // Original width calculation for other iPhones
        }

        var height = width
        if self.tempImage != nil {
            let ratio = self.tempImage.size.height / self.tempImage.size.width
            height = ratio * width
        }
        return CGSize(width: width, height: height)
    }

}
