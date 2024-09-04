//
//  BannerAd.swift
//  WhatsWeb
//
//  Created by APPLE STORE on 29/01/2024.
//

import Foundation
import UIKit
import GoogleMobileAds

@objc class BannerAd : NSObject
{
    var bannerView: GADBannerView!
    var parentVC : UIViewController!
    
    @objc func setupBannerAd(pVc : UIViewController) {
        if KeychainManager.isUserSubscribed() {
            return
        }
        
        self.parentVC = pVc
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = adIds.shared.bannerId
        bannerView.rootViewController = self.parentVC
        bannerView.delegate = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.parentVC.view.addSubview(bannerView)
        self.parentVC.view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: self.parentVC.view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: self.parentVC.view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
}

extension BannerAd : GADBannerViewDelegate
{
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
}
