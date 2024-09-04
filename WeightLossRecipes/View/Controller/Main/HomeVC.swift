//
//  HomeVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 18/09/2023.
//

import UIKit
import Alamofire
import GoogleMobileAds

class HomeVC: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var lbl_userName: UILabel!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var indicator_cv: UIActivityIndicatorView!
    var foodList = [HomeInfoModel]()
    var sideMenuVC = SideMenuVC()
    @IBOutlet var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    @IBOutlet var btn_subscribe : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        if KeychainManager.isUserSubscribed() {
            self.btn_subscribe.isHidden = true
        }
        
        indicator_cv.startAnimating()
      //  loadFullScreenAds()
        homeCatApi()
        
        lbl_userName.text = "Hello, \(KeychainManager.shared.getUserName())"
        self.indicator.startAnimating()
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(baseImageURL)\(KeychainManager.shared.getUserProfileImage())"

                // Use Alamofire to download the image data
                AF.request(imageUrlString).responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Create a UIImage from the downloaded data
                        if let image = UIImage(data: data) {
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                // Set the downloaded image to the UIImageView
                                self.userProfile.image = image
                                self.indicator.stopAnimating()
                            }
                        }
                    case .failure(let error):
                        // Handle the error, e.g., show a placeholder image
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
        
        userProfile.layer.cornerRadius = userProfile.layer.frame.width / 2
        userProfile.clipsToBounds = true
        userProfile.layer.borderWidth = 2
        userProfile.layer.borderColor = (UIColor.white).cgColor
        
       
        
    }
    
    func loadFullScreenAds()
    {
        let request = GADRequest()
           GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                                       request: request,
                             completionHandler: { [self] ad, error in
                               if let error = error {
                                 print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                 return
                               }
                               interstitial = ad
                               interstitial?.fullScreenContentDelegate = self
                               interstitial!.present(fromRootViewController: self)
                             }
           )
    }
    
    @IBAction func menuBtnClick(_ sender: UIButton)
    {
        let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        sideMenuVC.modalPresentationStyle = .overCurrentContext
        present(sideMenuVC, animated: true, completion: nil)
        
    }
    
    @IBAction func openPurchaseVC(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionVC") as! SubscriptionVC
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func openFavouriteVC(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func homeCatApi()
    {
        
        let homeViewModel = HomeViewModel()
        
        homeViewModel.GetHomeCategoryApi { response in
            
            if response.success == "true"
            {
                print(response.categories)
                
                let homeInfo = HomeInfoModel(id: nil, title: "Exercises", image: "logo_exercise", banner: nil)
                
                self.foodList.append(homeInfo)
                
                for recipe in response.categories
                {
                    
                    let homeInfo = HomeInfoModel(id: recipe.id, title: recipe.title, image: recipe.image, banner: recipe.banner)
                    
                    self.foodList.append(homeInfo)
                    
                }
                
                self.tableView.reloadData()
                self.indicator_cv.stopAnimating()
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
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        var modelInfo = foodList[indexPath.row]
        cell.lbl_title.text = modelInfo.title!
        cell.lbl_review.text = "very best"
       
        cell.selectionStyle = .none
        
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(baseImageURL)\(modelInfo.image!)"

                // Use Alamofire to download the image data
                AF.request(imageUrlString).responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Create a UIImage from the downloaded data
                        if let image = UIImage(data: data) {
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                // Set the downloaded image to the UIImageView
                                
                                cell.thumbnail.image = image
                            }
                        }
                    case .failure(let error):
                        // Handle the error, e.g., show a placeholder image
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
        
        if indexPath.row == 5{
            cell.thumbnail.image = UIImage(named: modelInfo.image!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        //cell.contentView.backgroundColor = UIColor(hex: "#00100e")
        
        if indexPath.row == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExercisesVC") as! ExercisesVC
         
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCategoryVC") as! HomeCategoryVC
            
            let modelInfo = foodList[indexPath.row]
            
            vc.catID = String(modelInfo.id!)
            vc.catTitle = modelInfo.title!
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
 }
    
   
    
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0

        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }

        guard hexSanitized.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

