//
//  Excercises.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 19/10/2023.
//

import Foundation

struct ExcercisesCatInfoModal{
    
    let title : String
    let gif_name: String
}

struct ExcercisesInfoModal{
    
    let ex_number : String
    let gif_name: String
}

struct ExSubCatInfoModel{

    let category_id, image_link: String?
    
}

struct ExListInfoModel{

    let ex_id: Int
    let ex_title, ex_image, ex_gif, ex_url: String?
    
}

struct ExSubCatModal: Decodable {
    let status: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Decodable {
    let id: Int
    let categoryID, title: String
    let description: Description
    let imageLink: String
    let image, createdAt, updatedAt: String
    let category: SubCategory

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, description
        case imageLink = "image_link"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case category
    }
}

// MARK: - Category
struct SubCategory: Decodable {
    let id: Int
    let name: Name
    let createdAt, updatedAt: AtedAt
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case order
    }
}

enum AtedAt: String, Codable {
    case the20231116T150839000000Z = "2023-11-16T15:08:39.000000Z"
    case the20231118T070715000000Z = "2023-11-18T07:07:15.000000Z"
}

enum Name: String, Codable {
    case menExe = "Men Exe"
    case womenExe = "Women Exe"
}

enum Description: String, Codable {
    case gim = "Gim"
}


//Ex subcategoryList Modal

struct ExerciseListModal: Decodable {
    let status: String
    let type: [CatTypeElement]
}

// MARK: - TypeElement
struct CatTypeElement: Decodable {
    let id: Int
    let name, createdAt, updatedAt: String
    let order: Int
    let category: [ListCategory]

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case order, category
    }
}

// MARK: - Category
struct ListCategory: Decodable {
    let id: Int
    let categoryID, title: String
    let description: Description
    let imageLink: String
    let image, createdAt, updatedAt: String
    let subcategory: [Subcategory]

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, description
        case imageLink = "image_link"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subcategory
    }
}

enum ListDescription: String, Codable {
    case gim = "Gim"
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let id: Int
    let subCategoryID, title: String
    let description: Description?
    let wallpaperImage, wallpaperGIF: String
    let wallpaperImageURL: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case subCategoryID = "sub_category_id"
        case title, description
        case wallpaperImage = "wallpaper_image"
        case wallpaperGIF = "wallpaper_gif"
        case wallpaperImageURL = "wallpaper_image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
