//
//  FoodModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 18/09/2023.
//

import Foundation

struct HomeInfoModel{
    
    let id: Int?
    let title, image, banner: String?
    
}

struct HomeCatModel: Decodable {
    let success: String
    let categories: [Category]
}

// MARK: - Category
struct Category: Decodable {
    let id: Int
    let title: String
    let slug: String?
    let image, banner, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, slug, image, banner
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

