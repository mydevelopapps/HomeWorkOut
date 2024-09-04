//
//  CategoryViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 20/09/2023.
//

import UIKit
import Alamofire

class CategoryViewModel{
    
    func callCategoryApi(parameters: categoryRequest, onSuccess completionalHandler: @escaping((_:CategoryResponse) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {
        
      
        AF.request(CategoryApi,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let catResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
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
