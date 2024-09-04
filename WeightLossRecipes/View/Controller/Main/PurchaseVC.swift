//
//  PurchaseVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 12/10/2023.
//

import UIKit
import SwiftyStoreKit
import StoreKit

class PurchaseVC: UIViewController, SKProductsRequestDelegate {

    var timer : Timer!
    var currentIndex: Int!
    @IBOutlet var sliderCollectionViewHeight: NSLayoutConstraint!
    var tempImage : UIImage!
    @IBOutlet var collectionView: UICollectionView!
    var sliderArray = [String]()
    
    @IBOutlet var pageControl: UIPageControl!
    
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
    
    var subscriptionPackageID = "75623490"
    var subscriptionPackageID1 = "75623491"
    var subscriptionPackageID2 = "75623492"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var slider = String()
        slider = "slider1"
        sliderArray.append(slider)
        
        slider = "slider2"
        sliderArray.append(slider)
        
        slider = "slider3"
        sliderArray.append(slider)
        print(sliderArray.count)
        
        self.collectionView.reloadData()
        
        ThreeMonthsButtonOutlet.isSelected = true
        ThreeMonthsViewOutlet.layer.cornerRadius = 8
        ThreeMonthsViewOutlet.layer.masksToBounds = true
        ThreeMonthsViewOutlet.layer.borderWidth = 3
        ThreeMonthsViewOutlet.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.03137254902, blue: 0.337254902, alpha: 1)
        self.threeMonthsBtnPressed(self.ThreeMonthsButtonOutlet)
        
        
        self.indicator3Months.startAnimating()
        self.indicator6Months.startAnimating()
        self.indicator1Year.startAnimating()
        
        loadPacakgeInfo(GetPlans.sharedInstance.threeMonthsPlaniD)
        loadPacakgeInfo(GetPlans.sharedInstance.sixMonthsPlaniD)
        loadPacakgeInfo(GetPlans.sharedInstance.oneYearPlaniD)
        
        self.currentIndex = 1
        startTimerThread()
    }
   
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let currentIndex = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
//        pageControl.currentPage = Int(currentIndex)
//
//    }
//
    @IBAction func threeMonthsBtnPressed(_ sender: UIButton) {
        ThreeMonthsButtonOutlet.isSelected = true
        SixMonthsButtonOutlet.isSelected = false
        oneYearButtonOutlet.isSelected = false
        
        if ThreeMonthsButtonOutlet.isHighlighted {
            ThreeMonthsViewOutlet.layer.cornerRadius = 8
            ThreeMonthsViewOutlet.layer.masksToBounds = true
            ThreeMonthsViewOutlet.layer.borderWidth = 3
            ThreeMonthsViewOutlet.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.03137254902, blue: 0.337254902, alpha: 1)
            sixMonthsViewOutlet.layer.borderWidth = 0
            oneYearViewOutlet.layer.borderWidth = 0
            sixMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            oneYearViewOutlet.layer.borderColor = UIColor.clear.cgColor
            
            self.subscriptionPackageID = GetPlans.sharedInstance.threeMonthsPlaniD
            print("\(GetPlans.sharedInstance.threeMonthsPlaniD)")
           
        }
        
        InAppPurchsing.purchaseProductWithProductID(productID: String(self.subscriptionPackageID), parentVC: self)
        print("\(self.subscriptionPackageID)")
    }

    @IBAction func sixMonthsBtnPressed(_ sender: Any) {
        
        ThreeMonthsButtonOutlet.isSelected = false
        SixMonthsButtonOutlet.isSelected = true
        oneYearButtonOutlet.isSelected = false
        
        if SixMonthsButtonOutlet.isHighlighted {
            sixMonthsViewOutlet.layer.cornerRadius = 8
            sixMonthsViewOutlet.layer.masksToBounds = true
            sixMonthsViewOutlet.layer.borderWidth = 3
            sixMonthsViewOutlet.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.03137254902, blue: 0.337254902, alpha: 1)
            ThreeMonthsViewOutlet.layer.borderWidth = 0
            oneYearViewOutlet.layer.borderWidth = 0
            ThreeMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            oneYearViewOutlet.layer.borderColor = UIColor.clear.cgColor
            print("\(GetPlans.sharedInstance.sixMonthsPlaniD)")
            self.subscriptionPackageID = GetPlans.sharedInstance.sixMonthsPlaniD
        }
        
        if self.SixMonthsButtonOutlet.isSelected {
            InAppPurchsing.purchaseProductWithProductID(productID: String(self.subscriptionPackageID1), parentVC: self)
    print("\(self.subscriptionPackageID1)")
        }
    }
    
    @IBAction func oneYearBtnPressed(_ sender: Any) {
        
        ThreeMonthsButtonOutlet.isSelected = false
        SixMonthsButtonOutlet.isSelected = false
        oneYearButtonOutlet.isSelected = true
        
        if oneYearButtonOutlet.isHighlighted {
            oneYearViewOutlet.layer.cornerRadius = 8
            oneYearViewOutlet.layer.masksToBounds = true
            oneYearViewOutlet.layer.borderWidth = 3
            oneYearViewOutlet.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.03137254902, blue: 0.337254902, alpha: 1)
            ThreeMonthsViewOutlet.layer.borderWidth = 0
            sixMonthsViewOutlet.layer.borderWidth = 0
            ThreeMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            sixMonthsViewOutlet.layer.borderColor = UIColor.clear.cgColor
            print("\(GetPlans.sharedInstance.oneYearPlaniD)")
            self.subscriptionPackageID = GetPlans.sharedInstance.oneYearPlaniD
      
        }
        
        if self.oneYearButtonOutlet.isSelected {
            InAppPurchsing.purchaseProductWithProductID(productID: String(self.subscriptionPackageID2), parentVC: self)
            print("\(self.subscriptionPackageID2)")
        }
        
    }

    
    func loadPacakgeInfo(_ packageID: String?) {
        var req: SKProductsRequest? = nil
        if let set = Set<AnyHashable>([packageID]) as? Set<String> {
            req = SKProductsRequest(productIdentifiers: set)
        }
        req?.delegate = self
        req?.start()
    }

    @objc(productsRequest:didReceiveResponse:) func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let pr = response.products
        if response.products.count != 0 {
            let product = response.products[0]
            if product != nil {
                updateProductPrice(product)
            }
        }
    }

    func updateProductPrice(_ product: SKProduct?) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product?.priceLocale
       
        if GetPlans.sharedInstance.threeMonthsPlaniD == product?.productIdentifier {
            DispatchQueue.main.async(execute: { [self] in
                self.indicator3Months.stopAnimating()
                
                if #available(iOS 15.0, *) {
                    ThreeMonthsButtonOutlet.configuration?.subtitle = "3 Months"
                    ThreeMonthsButtonOutlet.tintColor = .white
                } else {
                    // Fallback on earlier versions
                }
                
                //NSString *currencyCode = product.priceLocale.countryCode;
                var price: String? = nil
                if let aPrice = product?.price {
                    price = formatter.string(from: aPrice)
                }
                //ThreeMonthsButtonOutlet.setTitle(price, for: .normal)
                ThreeMonthsLabelOutlet.text = price
              //  ThreeMonthsPlan.text = price
            })
        } else if GetPlans.sharedInstance.sixMonthsPlaniD == product?.productIdentifier {
            DispatchQueue.main.async(execute: { [self] in
                self.indicator6Months.stopAnimating()
                
                if #available(iOS 15.0, *) {
                    SixMonthsButtonOutlet.configuration?.subtitle = "6 Months"
                    SixMonthsButtonOutlet.tintColor = .white
                } else {
                    // Fallback on earlier versions
                }
                
                //NSString *currencyCode = product.priceLocale.countryCode;
                var price: String? = nil
                if let aPrice = product?.price {
                    price = formatter.string(from: aPrice)
                }
                //SixMonthsButtonOutlet.setTitle(price, for: .normal)
                SixMonthsLabelOutlet.text = price
               // SixMonthsPlan.text = price
            })
        } else if GetPlans.sharedInstance.oneYearPlaniD == product?.productIdentifier {
            DispatchQueue.main.async(execute: { [self] in
                self.indicator1Year.stopAnimating()
                
                if #available(iOS 15.0, *) {
                    oneYearButtonOutlet.configuration?.subtitle = "1 Year"
                    oneYearButtonOutlet.tintColor = .white
                } else {
                    // Fallback on earlier versions
                }
                
                //NSString *currencyCode = product.priceLocale.countryCode;
                var price: String? = nil
                if let aPrice = product?.price {
                    price = formatter.string(from: aPrice)
                }
                oneYearButtonOutlet.setTitle(price, for: .normal)
                oneYearLabelOutlet.text = price
                
             //   OneYearPlan.text = price
            })
        }
    }

    @IBAction func dismisVC(_ sender: UIButton) {
           // Dismiss the side menu view controller
           dismiss(animated: true, completion: nil)
       }
    
    func startTimerThread() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc func timerAction() {
        currentIndex = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        
        if currentIndex < sliderArray.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
    }

    
    
}

extension PurchaseVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        let slider = sliderArray[indexPath.row]
        
        cell.thumbnail.image = UIImage(named: slider)
        return cell
    }
    
}

extension PurchaseVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.size.width
        
        var height = width
        if self.tempImage != nil {
            let ratio = self.tempImage.size.height / self.tempImage.size.width
            height = ratio * width
        }
        
        self.sliderCollectionViewHeight.constant = height;
        
        return CGSize(width: width, height: height)
    }

}




