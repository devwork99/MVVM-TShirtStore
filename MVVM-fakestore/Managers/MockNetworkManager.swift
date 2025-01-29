//
//  MockNetworkManager.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 29/01/2025.
//

import Foundation
import Combine

class MockNetworkManager  : NetworkManagerProtocol {
    
    let first = ProductModel(id:101, title:"first product", price:23.8, description: "first product long long description", category:"Clothing", image:"", rating:Rating(rate: 3.0, count:23))
    
    let two = ProductModel(id:101, title:"first product", price:23.8, description: "first product long long description", category:"Clothing", image:"", rating:Rating(rate: 3.0, count:23))
    
    let three = ProductModel(id:101, title:"first product", price:23.8, description: "first product long long description", category:"Clothing", image:"", rating:Rating(rate: 3.0, count:23))
    
    //we are going to use the Just publisher, that publish just one value and never fails.
    func getTheProductsWithCombine() -> AnyPublisher<[ProductModel], Error> {
        Just([first,two,three])
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
}
