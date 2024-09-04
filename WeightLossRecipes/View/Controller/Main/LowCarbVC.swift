//
//  LowCarbVC.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 03/10/2023.
//

import UIKit
import GoogleMobileAds
import WebKit
class LowCarbVC: UIViewController, GADBannerViewDelegate {

    var lowCarbList = [LowCarbsInfoModel]()
    var updatedLowCarbList = [LowCarbsInfoModel]()
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var webView: WKWebView!
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerAd = BannerAd()
        bannerAd.setupBannerAd(pVc: self)
        
        indicator.startAnimating()
        getLowCarbsApi()
        
    }
    
    func getLowCarbsApi()
    {
        
        let lowCarbsModel = LowCarbsViewModel()
        
        lowCarbsModel.CallLowCarbsApi { response in
            
            if response.success == "true"
            {
                print(response.faqs)
                
                for info in response.faqs
                {
                    let lowCarbInfo = LowCarbsInfoModel(title: info.title!, descriptions: info.descriptions!, isDetail: false, isSelected: false, isCellSelected: false)
                    
                    self.lowCarbList.append(lowCarbInfo)
                    
                }
                
                self.collectionView.reloadData()
               
                
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
    
    @IBAction func goToBackScreen()
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LowCarbVC: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lowCarbList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     
        let info = self.lowCarbList[indexPath.row];
       
        self.indicator.stopAnimating()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! CollectionCell
            cell.lbl_title.text = info.title;
            
            
            if (info.isSelected == true) {
                cell.lbl_title.textColor = UIColor.white;
                cell.layer.cornerRadius = 28;
                cell.contentView.backgroundColor = UIColor(hex: "#00A88F")
                cell.layer.masksToBounds = true;
            }else{
                cell.lbl_title.textColor = UIColor.black;
                cell.layer.cornerRadius = 28;
                cell.layer.borderWidth = 2;
                cell.layer.borderColor = UIColor(hex: "#00A88F").cgColor
                cell.contentView.backgroundColor = UIColor.clear;
                cell.layer.masksToBounds = true;
            }
            print(info.isCellSelected)
            if (indexPath.row == 0 && info.isCellSelected == false) {
             
                loadLowCarbsDescription(info.descriptions)
                
                cell.lbl_title.textColor = UIColor.white;
                cell.layer.cornerRadius = 28;
                cell.contentView.backgroundColor = UIColor(hex: "#00A88F")
                cell.layer.masksToBounds = true;
            }

            
        return  cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        var info = lowCarbList[indexPath.row];
        print(info.isCellSelected)
        
        for i in lowCarbList.indices
        {
            lowCarbList[i].isSelected = false
            
        }
        
        lowCarbList[indexPath.row].isSelected = true
        
        if (indexPath.row > 0) {
            var info = lowCarbList[0]
            lowCarbList[0].isCellSelected = true
            print(info.isCellSelected)
        }
     
        loadLowCarbsDescription(info.descriptions)
        collectionView.reloadData()
    }
    
    func loadLowCarbsDescription(_ descriptions: Any)
    {
        
        let strCssHead = """
            <head>
            <link rel="stylesheet" type="text/css" href="EnCss.css">
            </head>
            """
        let htmlContent = "\(strCssHead)<body><div><h1>\(descriptions)</h1></div></body>"

        if let cssURL = Bundle.main.url(forResource: "EnCss", withExtension: "css"){
            self.webView.loadHTMLString(htmlContent, baseURL: cssURL)
        }
        self.webView.loadHTMLString(htmlContent, baseURL: nil)
        let delayInSeconds = 1.0
        let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)


    }
    
    
    
   
}
