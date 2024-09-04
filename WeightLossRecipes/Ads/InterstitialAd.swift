//
//  Interstitial.swift
//  WhatsWeb
//
//  Created by APPLE STORE on 05/02/2024.
//

import Foundation
import GoogleMobileAds

@objc class InterstitialAd : NSObject,GADFullScreenContentDelegate
{
    private var interstitial: GADInterstitialAd?
    var parentVC : UIViewController!
    
    @objc static var shared =  InterstitialAd()
    
    @objc func setInterstitialAd() {
        if KeychainManager.isUserSubscribed() {
            return
        }
        
        // In this case, we instantiate the banner with desired ad size.
        interstitial = nil
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: adIds.shared.fullScreenId,
                request: request,
              completionHandler: { [self] ad, error in
                if let error = error {
                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                  return
                }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
                
                if let topViewController = UIApplication.topViewController() {
                    // Use topViewController
                    interstitial?.present(fromRootViewController: topViewController)
                }
      })
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
          self.setInterstitialAd()
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
