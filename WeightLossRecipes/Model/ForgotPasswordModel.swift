//
//  ForgotPasswordModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 26/09/2023.
//

import Foundation

struct ForgotPasswordRequest: Encodable{
    
    let email: String
}


struct ForgotPasswordResponse: Decodable{
    
    let success: String
    let message: String
}

struct UpdatePasswordRequest: Encodable{
    
    var email: String
    var code: String
    var new_password: String
}

struct UpdatePasswordResponse: Decodable{
    
    let success: String
    let message: String
}
