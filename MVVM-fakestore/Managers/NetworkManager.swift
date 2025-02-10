//
//  WebService.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import Foundation
import Combine



let baseUrl = "https://fakestoreapi.com/products"

struct Endpoints {
    
    var productsDesc : String { return baseUrl + "/?sort=desc" }
    
    var productsAsc : String { return baseUrl + "/?sort=desc" }
}


enum NetworkError : Error {
    case badURL
    case badResponse
    case decodeError
}


protocol NetworkManagerProtocol {
    func fetchProductsWithCombine() -> AnyPublisher <[ProductModel], Error>
}



class NetworkManager : NetworkManagerProtocol {
    
    //can not be private, static, becasue we have pass on the dependency from outside
    //with dependency injection is alternative to Singleton, the problems with singleton is its global access point, when huge app with multi threads try to access the app, it can crash, the init method can't be customised, we can't swap out between production/quality/dev services, So we use the dependency injection method, inject the network layout from outside to viewmodels.
    //static let shared = NetworkManager()
    //private init(){}
    
    //var cancellables = Set<AnyCancellable>()
    
    //lets do everything with Combine
    func fetchProductsWithCombine() -> AnyPublisher <[ProductModel], Error>{
        
        //guard let url = URL(string: "https://fakestoreapi.com/products?sort=desc") else {
        
        guard let url = URL(string: Endpoints().productsAsc) else {
            //return publisher with error inside
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //with Async Await
    func getSortedProducts() async throws -> [ProductModel] {
        
        guard let url = URL(string: Endpoints().productsAsc) else {
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
