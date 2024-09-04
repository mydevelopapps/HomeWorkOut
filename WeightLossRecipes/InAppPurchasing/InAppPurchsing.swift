//
//  InAppPurchsing.swift
//  ScoliotrackNew
//
//  Created by Curiologix on 08/05/2022.
//  Copyright © 2022 Curiologix. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import MBProgressHUD

var parentVC = UIViewController()


class InAppPurchsing : NSObject
{
    @objc public static let sharedInstance = InAppPurchsing()

    @objc class public func purchaseProductWithProductID(productID : String, parentVC : UIViewController)
    {
        parentVC.self.showActivity()
        SwiftyStoreKit.purchaseProduct(productID, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                //self.productPurchasedOrRestore(produc: purchase.product);
                //self.verifyReceipt(productID: StaticData.ProductID2);

                parentVC.dissmissActivity()
                print("Purchase Success: \(purchase.productId)")


                //StaticData.showAlertView("Purchase Success")
                KeychainManager.shared.setPurchasedProductID(true, key: productID)
                StaticClass.setupHomeRoot()
            case .error(let error):
                parentVC.dissmissActivity()
                switch error.code {
                case .unknown:
                    self.restorePurchases(parentVC: UIViewController())
                    parentVC.showAlertWithTitle(title: "", message: "Unknown error. Please try again", options: "Ok")
                    break
                case .clientInvalid:
                    parentVC.showAlertWithTitle(title: "", message: "Not allowed to make the payment", options: "Ok")
                case .paymentCancelled: break;
                    //self.purchaseProductWithProductID(purchase: purchase);
                case .paymentInvalid:
                    parentVC.showAlertWithTitle(title: "", message: "The purchase identifier was invalid", options: "Ok")
                case .paymentNotAllowed:
                    parentVC.showAlertWithTitle(title: "", message: "The device is not allowed to make the payment", options: "Ok")
                case .storeProductNotAvailable:
                    parentVC.showAlertWithTitle(title: "", message: "The product is not available in the current storefront", options: "Ok")
                case .cloudServicePermissionDenied:
                    parentVC.showAlertWithTitle(title: "", message: "Access to cloud service information is not allowed", options: "Ok")
                case .cloudServiceNetworkConnectionFailed:
                    parentVC.showAlertWithTitle(title: "", message: "Could not connect to the network", options: "Ok")
                case .cloudServiceRevoked:
                    parentVC.showAlertWithTitle(title: "", message: "User has revoked permission to use this cloud service", options: "Ok")
//                case .privacyAcknowledgementRequired:
//                    //self.showAlert(message: "e");
//                case .unauthorizedRequestData:
//                    self.showAlert(message: "e");
//                case .invalidOfferIdentifier:
//                    self.showAlert(message: "e");
//                case .invalidSignature:
//                    self.showAlert(message: "e");
//                case .missingOfferParams:
//                    self.showAlert(message: "e");
//                case .invalidOfferPrice:
//                    self.showAlert(message: "e");
                default:
                    break;
                }
            }
        }
    }


    @objc class func completionTransaction()
    {
        // see notes below for the meaning of Atomic / Non-Atomic
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }
    }


    @objc class func restorePurchases( parentVC : UIViewController)
           {
               // self.showActivity()
               parentVC.self.showActivity()
             SwiftyStoreKit.restorePurchases(atomically: true) { results in

                 parentVC.self.dissmissActivity()

               if results.restoreFailedPurchases.count > 0 {
                   print("Restore Failed: \(results.restoreFailedPurchases)")
                   parentVC.self.showAlertWithTitle(title: "", message: "Restore Failed: \(results.restoreFailedPurchases)", options: "Ok")
               }
               else if results.restoredPurchases.count > 0 {
                   print("Restore Success: \(results.restoredPurchases)")

                 for purchase in results.restoredPurchases
                 {
                     KeychainManager.shared.setPurchasedProductID(true, key: purchase.productId)
            //       StaticData.setUserSubscribed(true, withSubscribedPlanID: purchase.productId)

                 }
                   parentVC.self.showAlertWithTitle(title: "", message: "Restore Purchases Success", options: "Ok")
                   StaticClass.setupHomeRoot()
               }
               else {
                 print("Nothing to Restore")
                   parentVC.self.showAlertWithTitle(title: "", message: "Nothing to Restore", options: "Ok")
               }
             }
           }

    @objc class func verifyReceiptIAPValidation(productID : String,  parentVC : UIViewController?)
    {
        let sharedSecret = "b877abf3edc848869a3215edb6a01436"

        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                // Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable, // or .nonRenewing (see below)
                    productId: productID,
                    inReceipt: receipt)

                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productID) is valid until \(expiryDate)\n\(items)\n")
                    //self.showAlert(message: "\(productId) is valid until \(expiryDate)\n\(items)\n");
                    KeychainManager.shared.setPurchasedProductID(true, key: productID)
                case .expired(let expiryDate, let items):
                    parentVC?.showAlertWithTitle(title: "", message: "Your product has been expired, please renew your subscriptions", options: "Ok")
                    print("\(productID) is expired since \(expiryDate)\n\(items)\n")
                    KeychainManager.shared.setPurchasedProductID(false, key: productID)
                    StaticClass.setupHomeRoot()
                case .notPurchased:
                    print("The user has never purchased \(productID)")
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }

}
