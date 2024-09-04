//
//  KeychainManager.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 17/09/2023.
//

import Foundation
import KeychainSwift

class KeychainManager{
    
    static let shared = KeychainManager()
    let keychain = KeychainSwift()
    
    private init(){}
    
    func setKeychainString(stringObj: String, for key: String)
    {
        keychain.set(stringObj, forKey: key)
    }
    
    func getKeychainString(for key: String) -> String?
    {
        if (keychain.get(key) != nil)
        {
           return keychain.get(key)!
        }
        
        return nil
    }
    
    func setKeychainData(dataObj: Data, for key: String)
    {
        keychain.set(dataObj, forKey: key)
    }
    
    func getKeychainData(for key: String) -> Data?
    {
        if (keychain.getData(key) != nil)
        {
            return keychain.getData(key)
        }
        
        return nil
    }
    
    func setKeychainBool(boolObj: Bool, for key: String)
    {
        keychain.set(boolObj, forKey: key)
    }
    
    func getKeychainBool(for key: String) -> Bool?
    {
        if (keychain.getBool(key) != nil)
        {
            return keychain.getBool(key)!
        }
        
        return nil
    }
    
    
    func deleteKeychain(for key: String)
    {
        keychain.delete(key)
    }
    
    func clearKeychain()
    {
        keychain.clear()
    }
    
    
    func setUserName(_ value: String)  {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "Name")
    }
    
    
    func getUserName() -> String {
        return KeychainManager.shared.getKeychainString(for: "Name") ?? ""
    }
    
    func setUserEmail(_ value: String)  {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "Email")
    }
    
    
    func getUserEmail() -> String {
        return KeychainManager.shared.getKeychainString(for: "Email") ?? ""
    }
    
    
    func setUserPassword(_ value: String)  {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "Password")
    }
    
    
    func getUserPassword() -> String {
        return KeychainManager.shared.getKeychainString(for: "Password") ?? ""
    }
    
   
    func setUserToken(_ value: String) {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "userToken")
    }
    
    func getUsertoken() -> String{
        return KeychainManager.shared.getKeychainString(for: "userToken") ?? ""
    }
    
    func setDeviceToken(_ value: String) {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "devicetoken")
    }
    
    func getDeviceToken() -> String{
        return KeychainManager.shared.getKeychainString(for: "devicetoken") ?? ""
    }
    
    
    func setUserId(_ value: Int) {
        KeychainManager.shared.setKeychainString(stringObj: String(value), for: "userId")
    }
    
    func getUserId() -> String{
        return KeychainManager.shared.getKeychainString(for: "userId") ?? ""
    }
    
    func setUserProfileImage(_ value: String) {
        KeychainManager.shared.setKeychainString(stringObj: value, for: "profileImage")
    }
    
    func getUserProfileImage() -> String{
        return KeychainManager.shared.getKeychainString(for: "profileImage") ?? ""
    }
    
    func setRevenueCat(_ value: Bool, key: String) {
        KeychainManager.shared.setKeychainBool(boolObj: value, for: key)
    }
    
    func getRevenueCat(key : String) -> Bool{
        return KeychainManager.shared.getKeychainBool(for: key) ?? false
    }
    
    func setPurchasedProductID(_ value: Bool, key: String) {
        KeychainManager.shared.setKeychainBool(boolObj: value, for: key)
    }
    
    func getPurchasedProductByID(productID : String) -> Bool{
        return KeychainManager.shared.getKeychainBool(for: productID) ?? false
    }
    
    class func isUserSubscribed() -> Bool
    {
        let isSubscribed = KeychainManager.shared.getRevenueCat(key: "isPurchase")
        return isSubscribed
    }
    
    
    
}
