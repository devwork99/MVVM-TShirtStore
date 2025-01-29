//
//  ProductModel.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import Foundation

// MARK: - Welcome
struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}


func sampleProduct()->ProductModel{
    
  return ProductModel(id:7865,
                      title: "This is a sample Title of the Product",
                      price:45,
                      description:"This is a sample description",
                      category:"Fasion - clothing", image: "uououo890809",
                      rating:Rating(rate:1.9, count: 78))
    

}
