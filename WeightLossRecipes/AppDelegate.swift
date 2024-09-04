//
//  AppDelegate.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import UIKit
import Purchases

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // window?.overrideUserInterfaceStyle = .light
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        Purchases.configure(withAPIKey: "appl_YybfiqGsKsCyithIwuEqvjotcXf")
        Purchases.debugLogsEnabled = false
        
        if KeychainManager.isUserSubscribed() {
            self.checkSubscriptionStatus()
        }
        
//        if KeychainManager.shared.getUserId().count == 0
//        {
//            StaticClass.setupAuthRoot()
//        }else
//        {
            StaticClass.setupHomeRoot()
        //}
        
        window?.makeKeyAndVisible()
        return true
    }

    func checkSubscriptionStatus()
    {
        Purchases.shared.purchaserInfo { [weak self] info, error in
            guard let info = info, error == nil else { return }
            
            print(info.entitlements.all)
            
            if info.entitlements.all["pro"]?.isActive == true {
                DispatchQueue.main.async {
                 //   Persistance.shared.isProVersion = true
                    KeychainManager.shared.setRevenueCat(true, key: "isPurchase")
                }
            }else {
                DispatchQueue.main.async {
                    KeychainManager.shared.setRevenueCat(false, key: "isPurchase")
                    StaticClass.setupHomeRoot()
                }
            }
        }
    }

}

