//
//  Constants.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import Foundation
import UIKit

//let baseURL = "https://keto-app.limpidsol.com/api/"
let baseURL = "http://keto-app.aiwallstudio.com/admin"
let registerURL = "https://keto-app.limpidsol.com/api/signup"
let LoginURL = "https://keto-app.limpidsol.com/api/login"
let ForgotPasswordURL = "https://keto-app.limpidsol.com/api/forgot-password"
let UpdatePasswordURL = "https://keto-app.limpidsol.com/api/update-password"
let DeleteMyAccountURL = "https://keto-app.limpidsol.com/api/delete-my-account"
let baseImageURL = "https://keto-app.limpidsol.com/"
let exBaseImageURL = "https://exercises.limpidsol.com/"

let GetHomeCatApi = "https://keto-app.limpidsol.com/api/get-categories"
let CategoryApi = "https://keto-app.limpidsol.com/api/get-recipe-by-category"
let DetailApi = "https://keto-app.limpidsol.com/api/get-recipe"
let AddOrRemoveFavApi = "https://keto-app.limpidsol.com/api/add-or-remove-favourite"
let GetFavouriteApi = "https://keto-app.limpidsol.com/api/get-favourite-recipes"
let LowCarbsApi = "https://keto-app.limpidsol.com/api/get-faqs"
let RateApi = "https://keto-app.limpidsol.com/api/rate-recipe"
let GetReviewApi = "https://keto-app.limpidsol.com/api/get-recipe-reviews"
let GetExSubCatApi = "https://exercises.limpidsol.com/api/subCategories"
let GetExerciseListApi = "https://exercises.limpidsol.com/api/exercises"

class StaticClass: NSObject{
    
    static var sharedInstance = StaticClass()
    
    class func setupAuthRoot()
    {
        let authRoot = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthRoot")
        if let window = UIApplication.shared.delegate?.window {
            // access window. properties now
            window?.rootViewController = authRoot
        }
    }
    
    class func setupHomeRoot()
    {
        let authRoot = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeRoot")
        if let window = UIApplication.shared.delegate?.window {
            // access window. properties now
            window?.rootViewController = authRoot
        }
        //UIApplication.shared.delegate?.window?!.rootViewController = authRoot
    }
    
    
   class func isUserLogin() -> Bool
    {
       if KeychainManager.shared.getUserId().count == 0
        {
            return false
        }
        
        return true
    }
    
    class func logoutUser()
    {
        KeychainManager.shared.deleteKeychain(for: "Email")
        KeychainManager.shared.deleteKeychain(for: "Password")
        KeychainManager.shared.deleteKeychain(for: "userToken")
        KeychainManager.shared.deleteKeychain(for: "userId")
        KeychainManager.shared.deleteKeychain(for: "devicetoken")
        KeychainManager.shared.deleteKeychain(for: "profileImage")
    }
    
   class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func getDeviceUUID() -> String?
    {
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString
        {
            return deviceID
        }
        return nil
    }
    
    class func getTimeZone() ->String
    {
        let timeZone = TimeZone.current.identifier
        return timeZone
    }
   
}

class GetPlans: NSObject {
    static var sharedInstance = GetPlans()
    var threeMonthsPlaniD = "75623490"
    var sixMonthsPlaniD =  "75623491"
    var oneYearPlaniD = "75623492"
}

class adIds: NSObject {
    static var shared = adIds()
    var bannerId = "ca-app-pub-1589571400725626/9305408717"
    var fullScreenId = "ca-app-pub-1589571400725626/6903440802"
    var rewardedAdId = "ca-app-pub-1589571400725626/7591057665"
    
}



