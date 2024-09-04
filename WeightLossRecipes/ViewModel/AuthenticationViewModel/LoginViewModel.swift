//
//  LoginViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 13/09/2023.
//

import UIKit
import Alamofire


class LoginViewModel{
    
    
    func callLoginApi(parameters: LoginRequest, onSuccess completionalHandler: @escaping((_:LoginResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
      
        AF.request(LoginURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completionalHandler(loginResponse)
                        
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }else {
                    failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
                }
            }else {
                failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
            }
            
        }
    }
}

class DeleteAccountViewModal{
    
    func callDeleteAccountApi(parameters: DeleteAccountRequest, onSuccess completionalHandler: @escaping((_:DeleteAccountResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        
        AF.request(DeleteMyAccountURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let deleteResponse = try JSONDecoder().decode(DeleteAccountResponse.self, from: data)
                        completionalHandler(deleteResponse)
                        
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }else {
                    failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
                }
            }else {
                failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
            }
            
        }
    }
    
}
