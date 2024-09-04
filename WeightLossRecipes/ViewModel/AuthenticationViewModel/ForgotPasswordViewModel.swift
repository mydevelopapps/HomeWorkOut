//
//  ForgotViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/09/2023.
//

import UIKit
import Alamofire

class ForgotPasswordViewModel{
    
    func callForgotPassword(parameters: ForgotPasswordRequest, onSuccess completionalHandler: @escaping((_:ForgotPasswordResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
      
        AF.request(ForgotPasswordURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let forgotResponse = try JSONDecoder().decode(ForgotPasswordResponse.self, from: data)
                        completionalHandler(forgotResponse)
                        
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
    
    func callUpdatePassword(parameters: UpdatePasswordRequest, onSuccess completionalHandler: @escaping((_:UpdatePasswordResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
      
        AF.request(UpdatePasswordURL,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let updateResponse = try JSONDecoder().decode(UpdatePasswordResponse.self, from: data)
                        completionalHandler(updateResponse)
                        
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
