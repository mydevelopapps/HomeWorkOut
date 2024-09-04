//
//  DetailVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 21/09/2023.
//

import UIKit
import Alamofire
import WebKit
import GoogleMobileAds

class DetailVC: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate {

    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img5: UIImageView!
    @IBOutlet var img_detail: UIImageView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_review: UILabel!
    @IBOutlet var btn_favourite: UIButton!
    @IBOutlet var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var pIndicator: UIActivityIndicatorView!
    @IBOutlet var parentView: UIView!
    @IBOutlet var pWebView: UIView!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    
    var infoObj: String!
    var isFromFavList: Bool!
    var count: Int! = nil
    var recipeInfo: DetailInfoModel!
    var recipeInstructions: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        
        parentView.isHidden = true
        self.pIndicator.startAnimating()
        self.indicator.startAnimating()
        //lbl_title.text = infoObj.title
        
        self.pWebView.layer.cornerRadius = 12.0
        self.pWebView.clipsToBounds = true
        callDetailApi()

        var value: String
        let userDefaults = UserDefaults.standard
     
        if (userDefaults.value(forKey: "UserWatchScreenTime") == nil){
            
            self.count = 0
            userDefaults.set(String(count), forKey: "UserWatchScreenTime")
        }else{
            
            value = userDefaults.value(forKey: "UserWatchScreenTime") as! String
            let val: Int = Int(value)! + 1
            userDefaults.set(String(val), forKey: "UserWatchScreenTime")
        }
       
        value = userDefaults.value(forKey: "UserWatchScreenTime") as! String
        
        if Int(value)! >= 3
        {
            count = 0
            userDefaults.set(String(count), forKey: "UserWatchScreenTime")
            
            InterstitialAd.shared.setInterstitialAd()
        }
       
        checkRecipeIsFromFavoriteList()
        
    }
    
    func checkRecipeIsFromFavoriteList()
    {
        if isFromFavList
        {
            self.btn_favourite.setBackgroundImage(UIImage(named: "btn_favourite"), for: .normal)
        }
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
    
    @IBAction func goToFavScreen()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callDetailApi(){
        let params = DetailRequest(recipe_id: infoObj)
        
        let detailViewModel = DetailViewModel()
        detailViewModel.callDetialApi(parameters: params) { response in
            
            if response.success == "true"
            {
                print(response.recipe)
                
                    self.recipeInfo = DetailInfoModel(
                        id: response.recipe.id,
                        premium: response.recipe.premium,
                        reviewsCount: response.recipe.reviewsCount,
                        title: response.recipe.title,
                        banner_thumbnail: response.recipe.banner,
                        image_thumbnail: response.recipe.image,
                        ingrediants: response.recipe.ingredients,
                        instructions: response.recipe.instructions,
                        avg_rating: response.recipe.avgRating)
                    
                    
                     self.lbl_title.text = self.recipeInfo.title
                self.recipeInstructions = response.recipe.instructions
                     self.segmentControlAction(self)
                     self.loadDetailImage()
                     self.addStarRatings()
                self.parentView.isHidden = false
                self.pIndicator.stopAnimating()
                
              
            }
            
        } onFailure: { error in
            print(error)
        }

        
    }
    func loadDetailImage()
    {
        // Replace this URL with the actual image URL you want to load
        let imageUrlString = "\(baseImageURL)\(recipeInfo.image_thumbnail!)"

                // Use Alamofire to download the image data
                AF.request(imageUrlString).responseData { response in
                    switch response.result {
                    case .success(let data):
                        // Create a UIImage from the downloaded data
                        if let image = UIImage(data: data) {
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                // Set the downloaded image to the UIImageView
                               
                                var width = self.img_detail.frame.size.width
                                var height = width
                             
                                    let ratio = image.size.height / image.size.width
                                    height = ratio * width
                                
                                self.img_detail.image = image
                                
                                self.img_detail.frame.size = CGSize(width: width, height: height)
                                
                                self.indicator.stopAnimating()
                            }
                        }
                    case .failure(let error):
                        // Handle the error, e.g., show a placeholder image
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
    }


    func addStarRatings()
    {
        
        if recipeInfo.avg_rating != nil{
            
            print(recipeInfo.avg_rating!)
            
            if let ratingString = recipeInfo.avg_rating, let ratingDouble = Double(ratingString) {
                let value = Int(ratingDouble)
                
                if (value==1) {
                    self.img1.image = UIImage(named: "btn_favourite")
                }else if (value <= 2 && value != 0) {
                    self.img1.image = UIImage(named: "btn_favourite")
                    self.img2.image = UIImage(named: "btn_favourite")
                } else if (value <= 3 && value != 0) {
                    self.img1.image = UIImage(named: "btn_favourite")
                    self.img2.image = UIImage(named: "btn_favourite")
                    self.img3.image = UIImage(named: "btn_favourite")
                }else if (value <= 4 && value != 0) {
                    self.img1.image = UIImage(named: "btn_favourite")
                    self.img2.image = UIImage(named: "btn_favourite")
                    self.img3.image = UIImage(named: "btn_favourite")
                    self.img4.image = UIImage(named: "btn_favourite")
                }else if (value <= 5 && value != 0) {
                    self.img1.image = UIImage(named: "btn_favourite")
                    self.img2.image = UIImage(named: "btn_favourite")
                    self.img3.image = UIImage(named: "btn_favourite")
                    self.img4.image = UIImage(named: "btn_favourite")
                    self.img5.image = UIImage(named: "btn_favourite")
                }
            }
            
            
            self.lbl_review.text = self.recipeInfo.avg_rating;
            
        }

    }
    
    @IBAction func segmentControlAction(_ sender: Any)
    {
        if (self.recipeInstructions != nil){
            
            perform(#selector(loadInstructions(_:)), with: recipeInfo.instructions, afterDelay: 1.0)
            self.recipeInstructions = nil
        }else{
            switch segment.selectedSegmentIndex {
            case 0:
                
                perform(#selector(loadInstructions(_:)), with: recipeInfo.instructions, afterDelay: 1.0)
                
            case 1:
                
                perform(#selector(loadInstructions(_:)), with: recipeInfo.ingrediants, afterDelay: 1.0)
                
            default:
                break
            }
        }
        
    }
    
    @objc func loadInstructions(_ parameters: Any)
    {
        let instructions = parameters
        
        let strCssHead = """
            <head>
            <link rel="stylesheet" type="text/css" href="EnCss.css">
            </head>
            """
        let htmlContent = "\(strCssHead)<body><div><h1>\(instructions)</h1></div></body>"

        if let cssURL = Bundle.main.url(forResource: "EnCss", withExtension: "css"){
            webView.loadHTMLString(htmlContent, baseURL: cssURL)
        }
        webView.loadHTMLString(htmlContent, baseURL: nil)
        let delayInSeconds = 1.0
        let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

        DispatchQueue.main.asyncAfter(deadline: popTime) {
            self.webViewHeightConstraint.constant = self.webView.scrollView.contentSize.height
            self.viewDidLayoutSubviews()
           
        }
    }
    
    
    
    @IBAction func callAddOrRemoveFavApi(_ sender: UIButton)
    {
        self.indicator.startAnimating()
        let params = DetailRequest(recipe_id: infoObj)
        
        let detailViewModel = DetailViewModel()
        detailViewModel.callAddRemoveFavApi(parameters: params) { response in
            
            if response.success == "true"
            {
                
                
                print(response.message)
                if response.message == "Recipe added in favourites"
                {
                    self.btn_favourite.setBackgroundImage(UIImage(named: "btn_favourite"), for: .normal)
                }else
                {
                    self.btn_favourite.setBackgroundImage(UIImage(named: "un_fav"), for: .normal)
                }
                self.indicator.stopAnimating()
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
    
    @IBAction func goToReviewVC(_sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        vc.selectedObjId = self.recipeInfo.id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
