//
//  RegisterViewModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import UIKit
import Alamofire


class RegisterViewModel{
    
    func signupApirequest(signUpParameters: SignUp, image: UIImage, onSuccess successHandler: @escaping ((_: RegisterResponse) -> Void), onFailure failureHandler: @escaping ((_: String) -> Void)) {
        AF.upload(
            multipartFormData: { multipartFormData in
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: "profile_image", fileName: "profile_image.jpg", mimeType: "image/jpeg")
                }
                
                if let firstName = signUpParameters.first_name?.data(using: .utf8) {
                    multipartFormData.append(firstName, withName: "first_name")
                }
                
                if let lastName = signUpParameters.last_name?.data(using: .utf8) {
                    multipartFormData.append(lastName, withName: "last_name")
                }
                
                if let email = signUpParameters.email?.data(using: .utf8) {
                    multipartFormData.append(email, withName: "email")
                }
                
                if let password = signUpParameters.password?.data(using: .utf8) {
                    multipartFormData.append(password, withName: "password")
                }
                
                if let deviceID = signUpParameters.device_id?.data(using: .utf8) {
                    multipartFormData.append(deviceID, withName: "device_id")
                }
                
                if let deviceType = signUpParameters.device_type?.data(using: .utf8) {
                    multipartFormData.append(deviceType, withName: "device_type")
                }
                
                if let timezone = signUpParameters.timezone?.data(using: .utf8) {
                    multipartFormData.append(timezone, withName: "timezone")
                }
                
                
            },
            to: registerURL
        ).response { response in
            if response.error == nil {
                if let data = response.data {
                    do {
                        print(String(data: data, encoding: .utf8) ?? "")
                        let userResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                        successHandler(userResponse)
                    } catch let error {
                        failureHandler(error.localizedDescription)
                    }
                } else {
                    failureHandler(response.error?.localizedDescription ?? "SignUp Error please try again")
                }
            } else {
                failureHandler(response.error?.localizedDescription ?? "SignUp Error please try again")
            }
        }
    }

    
}
