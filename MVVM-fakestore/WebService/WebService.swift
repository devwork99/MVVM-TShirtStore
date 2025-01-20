//
//  WebService.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import Foundation


enum NetworkError : Error {
    case badURL
    case badResponse
    case decodeError
}



class WebService {
    
    
    //static let shared = WebService()
    //private init(){}
        
    func getAllProducts() async throws -> [ProductModel] {
        
        //make the url or throw
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.badURL
        }

        
        //get the data & response
        let (data, response) = try await URLSession.shared.data(for:URLRequest(url:url))
        
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw NetworkError.badResponse
        }
        
        //finally, lets decode the data
        
        guard let products = try? JSONDecoder().decode([ProductModel].self, from: data) else {
            throw NetworkError.decodeError
        }
        
        
        return products
        
    }
    
    
    func getSortedProducts() async throws -> [ProductModel] {
        
        guard let url = URL(string: "https://fakestoreapi.com/products?sort=desc") else {
            throw NetworkError.badURL
        }

        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url:url))
        
        
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let sortList = try? JSONDecoder().decode([ProductModel].self, from: data) else{
            throw NetworkError.decodeError
        }
        
        
        return sortList
    }
    
    
}
