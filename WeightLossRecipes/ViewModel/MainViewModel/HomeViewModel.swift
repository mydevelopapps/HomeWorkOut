//
//  HomeViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 25/09/2023.
//

import Foundation
import Alamofire

class HomeViewModel{
    
    func GetHomeCategoryApi(onSuccess completionalHandler: @escaping((_:HomeCatModel) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(KeychainManager.shared.getUsertoken())"
        ]
        
        AF.request(GetHomeCatApi,
                   method: .get,
                   parameters: [:],
                   encoding: URLEncoding.default, headers: headers).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let homeCatResponse = try JSONDecoder().decode(HomeCatModel.self, from: data)
                        completionalHandler(homeCatResponse)
                        
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
