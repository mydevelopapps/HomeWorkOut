//
//  ReviewViewModal.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 07/10/2023.
//

import Foundation
import Alamofire

class ReviewViewModel{
    
    func callRateApi(parameters: RateRequest, onSuccess completionalHandler: @escaping((_:RateResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        AF.request(RateApi,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let rateResponse = try JSONDecoder().decode(RateResponse.self, from: data)
                        completionalHandler(rateResponse)
                        
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
                    print(response.error)
                    failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
                }
            }else {
                failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
            }
            
        }
    }
    
    
    func callGetReviewApi(parameters: ReviewRequest, onSuccess completionalHandler: @escaping((_:ReviewResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        AF.request(GetReviewApi,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let reviewResponse = try JSONDecoder().decode(ReviewResponse.self, from: data)
                        completionalHandler(reviewResponse)
                        
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
                    print(response.error)
                    failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
                }
            }else {
                failureHandler(response.error?.localizedDescription ?? "Login Error please try again")
            }
            
        }
    }
    
    
}
