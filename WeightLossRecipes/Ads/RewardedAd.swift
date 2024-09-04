//
//  RewardedAd.swift
//  WhatsWeb
//
//  Created by APPLE STORE on 05/02/2024.
//

import Foundation
import GoogleMobileAds

class RewardedAd : NSObject,GADFullScreenContentDelegate
{
    private var rewardedAd: GADRewardedAd?
    static var shared =  RewardedAd()
    
    func loadRewardedAd() {
        if KeychainManager.isUserSubscribed() {
            return
        }
        
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:adIds.shared.rewardedAdId,
                           request: request,
                           completionHandler: { [self] ad, error in
          if let error = error {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
            return
          }
            rewardedAd = ad
            rewardedAd?.fullScreenContentDelegate = self
            if let topViewController = UIApplication.topViewController() {
                // Use topViewController
                rewardedAd?.present(fromRootViewController: topViewController, userDidEarnRewardHandler: {
                    
                })
            }
          print("Rewarded ad loaded.")
        }
        )
      }
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
          self.loadRewardedAd()
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
