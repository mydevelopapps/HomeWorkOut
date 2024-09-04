//
//  ExercisesViewModal.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 28/11/2023.
//

import Foundation
import Alamofire

class ExercisesViewModal{
    
    func GetExSubCategoryApi(onSuccess completionalHandler: @escaping((_:ExSubCatModal) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {

        AF.request(GetExSubCatApi,
                   method: .get,
                   parameters: [:],
                   encoding: URLEncoding.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let subCatResponse = try JSONDecoder().decode(ExSubCatModal.self, from: data)
                        completionalHandler(subCatResponse)
                        
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
    
    
    func GetExListApi(onSuccess completionalHandler: @escaping((_:ExerciseListModal) -> Void), onFailure failureHandler: @escaping((_:String) -> Void))
    {

        AF.request(GetExerciseListApi,
                   method: .get,
                   parameters: [:],
                   encoding: URLEncoding.default).response { response in
            
            if response.error == nil
            {
                if let data = response.data{
                    
                    do{
                        let subCatListResponse = try JSONDecoder().decode(ExerciseListModal.self, from: data)
                        completionalHandler(subCatListResponse)
                        
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
