//
//  SubscriptionVC.swift
//  WhatsWeb
//
//  Created by APPLE STORE on 02/02/2024.
//

import Foundation
import UIKit
import Purchases
import ProgressHUD
import StoreKit
class SubscriptionVC : UIViewController
{
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    var timer : Timer!
    var currentIndex: Int!
    @IBOutlet var sliderCollectionViewHeight: NSLayoutConstraint!
    var tempImage : UIImage!
    @IBOutlet var collectionView: UICollectionView!
    var sliderArray =  [subscriptionModel]()
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_description: UILabel!
    
    @IBOutlet var ThreeMonthsViewOutlet: UIView!
    @IBOutlet var sixMonthsViewOutlet: UIView!
    @IBOutlet var oneYearViewOutlet: UIView!
    
    @IBOutlet var ThreeMonthsButtonOutlet: UIButton!
    @IBOutlet var SixMonthsButtonOutlet: UIButton!
    @IBOutlet var oneYearButtonOutlet: UIButton!
    
    @IBOutlet var ThreeMonthsLabelOutlet: UILabel!
    @IBOutlet var SixMonthsLabelOutlet: UILabel!
    @IBOutlet var oneYearLabelOutlet: UILabel!
    
    @IBOutlet var indicator3Months: UIActivityIndicatorView!
    @IBOutlet var indicator6Months: UIActivityIndicatorView!
    @IBOutlet var indicator1Year: UIActivityIndicatorView!
    
    
    var threeMothsPackge: Purchases.Package!
    var sixMonthsPackge: Purchases.Package!
    var yearlyPackge: Purchases.Package!
    
    var selectedPackge: Purchases.Package!

    override func viewDidLoad() {
        
      var modal = subscriptionModel(thumbnail: "img1", title: "Manage Your Breakfast With Us", description: "ransform your breakfast routine with our offerings. Explore a range of delicious options tailored to your preferences. Start your day right by enjoying nutritious and satisfying meals with us. Experience convenience and quality, ensuring a delightful morning every time.")
        sliderArray.append(modal)
        
        modal = subscriptionModel(thumbnail: "img2", title: "Enhance Your Smoothie Making Process", description: "Elevate your smoothie-making game with our expert tips. Discover new ingredients and flavor combinations to create delicious and nutritious blends. Streamline your routine for a quick and satisfying way to boost your day. Maximize your health goals with each refreshing sip.")
        sliderArray.append(modal)

        modal = subscriptionModel(thumbnail: "img3", title: "Manage Your Eat Habits Now", description: "To manage your eating habits effectively, prioritize balanced meals with a variety of nutritious foods. Control portion sizes to avoid overeating, and stay hydrated by drinking plenty of water throughout the day. Limit processed foods and sugary snacks, opting instead for whole foods and mindful eating practices.")
          sliderArray.append(modal)
        
        modal = subscriptionModel(thumbnail: "img4", title: "Revamp Your Workout Routine", description: "Revamp your workout routine by incorporating new exercises, adjusting intensity levels, and diversifying your training methods. Keep your workouts engaging and challenging to avoid plateaus and maximize results. Listen to your body and make modifications as needed to ensure safety and effectiveness.")
          sliderArray.append(modal)
        
        modal = subscriptionModel(thumbnail: "img5", title: "Take Control Of Your Exercise Routine", description: "Assume authority over your workout regimen to tailor it to your needs and goals. Customize your exercises, intensity, and frequency to optimize results. Empower yourself to achieve fitness success by proactively managing your exercise routine. With dedication and consistency, reach new heights in your fitness journey.")
          sliderArray.append(modal)
        
        
        
        print(sliderArray.count)
        
        self.collectionView.reloadData()

        self.yearlyPurchased(self.oneYearButtonOutlet!)
        
        self.indicator3Months.startAnimating()
        self.indicator6Months.startAnimating()
        self.indicator1Year.startAnimating()
        
        self.loadAllPackgesFromRevenewCat()
        
    //let bannerAd = BannerAd()
       // bannerAd.setupBannerAd(pVc: self)
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback for earlier versions where requesting review is not available
            // You can implement your own custom prompt for ratings here
        }
    }
   
    func loadAllPackgesFromRevenewCat() {
        //ProgressHUD.show()

        Purchases.shared.offerings { offerings, error in
            guard let offerings = offerings, error == nil else {
                return
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            
            if let pacakges = offerings.all.first?.value.availablePackages
            {
                for pacakge in pacakges
                {
                    formatter.locale = pacakge.product.priceLocale
                    
                    var price: String? = nil
                    let aPrice = pacakge.product.price
                    price = formatter.string(from: aPrice)
                    
                    if pacakge.packageType == .weekly
                    {
                        self.threeMothsPackge = pacakge
                        self.ThreeMonthsLabelOutlet.text = price
                        self.indicator3Months.stopAnimating()
                        
                        //self.lbl_oneWeek.text = "Weekly"
                    } else if pacakge.packageType == .monthly
                    {
                        self.sixMonthsPackge = pacakge
                        self.SixMonthsLabelOutlet.text = price
                        self.indicator6Months.stopAnimating()
                     
                    } else if pacakge.packageType == .annual
                    {
                        self.yearlyPackge = pacakge
                        self.oneYearLabelOutlet.text = price
                        self.selectedPackge = pacakge
                        self.indicator1Year.stopAnimating()
                    }
                }
                
                ProgressHUD.dismiss()
            }
        }
    }
    
    func purchase(package: Purchases.Package) {
        //ProgressHUD.show()
        Purchases.shared.purchasePackage(package) { [weak self] transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let info = info,
                  error == nil, !userCancelled else {
                ProgressHUD.dismiss()
                return
            }
            if info.entitlements.all["pro"]?.isActive == true {
                DispatchQueue.main.async {
                 //   Persistance.shared.isProVersion = true
                    KeychainManager.shared.setRevenueCat(true, key: "isPurchase")
                    
                    StaticClass.setupHomeRoot()
                }
            }else {
                DispatchQueue.main.async {
                   // Persistance.shared.isProVersion = false
                    KeychainManager.shared.setRevenueCat(false, key: "isPurchase")
                }
            }
            ProgressHUD.dismiss()
          
        }
    }
    
    @IBAction func continePurchasing (_sender: UIButton)
    {
        self.purchase(package: self.selectedPackge)
    }
    
    @IBAction func threeMonthsBtnPressed(_ sender: UIButton) {
    
        ThreeMonthsButtonOutlet.isSelected = true
        SixMonthsButtonOutlet.isSelected = false
        oneYearButtonOutlet.isSelected = false
        
        if ThreeMonthsButtonOutlet.isSelected {
            ThreeMonthsViewOutlet.layer.cornerRadius = 8
            ThreeMonthsViewOutlet.layer.masksToBounds = true
            ThreeMonthsViewOutlet.layer.borderWidth = 2
            ThreeMonthsViewOutlet.layer.borderColor = UIColor(hex: "#00A88F").cgColor
            sixMonthsViewOutlet.layer.borderWidth = 0
            oneYearViewOutlet.layer.borderWidth = 0
            sixMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            oneYearViewOutlet.layer.borderColor = UIColor.clear.cgColor
           
        }
        
       // self.resetRadioSelection()
        
        self.selectedPackge = self.threeMothsPackge
    }
    
    @IBAction func sixMonthsBtnPressed(_ sender: Any) {
    
        ThreeMonthsButtonOutlet.isSelected = false
        SixMonthsButtonOutlet.isSelected = true
        oneYearButtonOutlet.isSelected = false
        
        if SixMonthsButtonOutlet.isSelected {
            sixMonthsViewOutlet.layer.cornerRadius = 8
            sixMonthsViewOutlet.layer.masksToBounds = true
            sixMonthsViewOutlet.layer.borderWidth = 2
            sixMonthsViewOutlet.layer.borderColor = UIColor(hex: "#00A88F").cgColor
            ThreeMonthsViewOutlet.layer.borderWidth = 0
            oneYearViewOutlet.layer.borderWidth = 0
            ThreeMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            oneYearViewOutlet.layer.borderColor = UIColor.clear.cgColor
            
        }
        
       // self.resetRadioSelection()
      
        self.selectedPackge = self.sixMonthsPackge
    }
    
    @IBAction func yearlyPurchased(_ sender: Any)
    {
        ThreeMonthsButtonOutlet.isSelected = false
        SixMonthsButtonOutlet.isSelected = false
        oneYearButtonOutlet.isSelected = true
        
        if oneYearButtonOutlet.isSelected {
            oneYearViewOutlet.layer.cornerRadius = 8
            oneYearViewOutlet.layer.masksToBounds = true
            oneYearViewOutlet.layer.borderWidth = 2
            oneYearViewOutlet.layer.borderColor = UIColor(hex: "#00A88F").cgColor
            ThreeMonthsViewOutlet.layer.borderWidth = 0
            sixMonthsViewOutlet.layer.borderWidth = 0
            ThreeMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            sixMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
          
        }
        
        //self.resetRadioSelection()
        self.selectedPackge = self.yearlyPackge
        
    }
    

    @IBAction func dismisVC(_ sender: UIButton) {
           // Dismiss the side menu view controller
           dismiss(animated: true, completion: nil)
       }
    
    
    
    @IBAction func close()
    {
        StaticClass.setupHomeRoot()
    }
    
    @IBAction func privacyPolicy()
    {
        UIApplication.shared.open(URL(string: "http://limpidsol.com/dual-chat-privacy-policy.html")!)
    }
    
    @IBAction func termCondition()
    {
        UIApplication.shared.open(URL(string: "http://limpidsol.com/dual-chat-messenger-wa-web-terms.html")!)
    }
    
    @IBAction func termOfUse()
    {
        UIApplication.shared.open(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
    }
}

extension SubscriptionVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.indicator.startAnimating()
        let slider = sliderArray[indexPath.row]
        
        cell.thumbnail.image = UIImage(named: slider.thumbnail)
    
        if self.tempImage == nil {
            self.tempImage = UIImage(named: slider.thumbnail)
            self.collectionView.reloadData()
        }
        cell.indicator.stopAnimating()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        var width: CGFloat = 0.0

        // Set your desired width for each item
        width = frame.width

        // Calculate height based on the width
        var height = width
        if let tempImage = self.tempImage {
            let ratio = tempImage.size.height / tempImage.size.width
            height = ratio * width
        }

        // Add any additional height if needed
      

        return CGSize(width: width, height: height)
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {
            return
        }
        
        let currentPage = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        // Update the page control of the cell
        self.pageControl.currentPage = currentPage
        let slider = sliderArray[currentPage]
        
        lbl_title.text = slider.title
        lbl_description.text = slider.description
        
//        // Get visible cells
//        let visibleCells = collectionView.visibleCells
//
//        // Loop through visible cells
//        for cell in visibleCells {
//            // Cast cell to OuterCollectionViewCell
//            if let outerCell = cell as? CollectionCell {
//                // Get the index path of the cell
//                if let indexPath = collectionView.indexPath(for: outerCell) {
//                    // Calculate current page based on content offset
//                    let currentPage = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
//                    // Update the page control of the cell
//                    outerCell.pageControl.currentPage = currentPage
//                }
//            }
//        }
    }

    
}

