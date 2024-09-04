//
//  DetailViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 21/09/2023.
//

import Foundation
import Alamofire

class DetailViewModel{
    
    
    func callDetialApi(parameters: DetailRequest, onSuccess completionalHandler: @escaping((_:DetailRecipeResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        AF.request(DetailApi,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let catResponse = try JSONDecoder().decode(DetailRecipeResponse.self, from: data)
                        completionalHandler(catResponse)
                        
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
    
    func callAddRemoveFavApi(parameters: DetailRequest, onSuccess completionalHandler: @escaping((_:AddRemoveFavResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        AF.request(AddOrRemoveFavApi,
                   method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let catResponse = try JSONDecoder().decode(AddRemoveFavResponse.self, from: data)
                        completionalHandler(catResponse)
                        
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
