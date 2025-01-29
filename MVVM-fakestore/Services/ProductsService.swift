//
//  ProductsService.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 28/01/2025.
//

import Foundation



//protocol ProdcutsServiceProtocol {
//
//    func fetchAllProdcts(completion: @escaping(Result<[ProductModel],Error>)->())
//
//}
//
//class ProductsService: ProdcutsServiceProtocol {
//
//    //inject the dependency
//    var client : NetworkManager
//    //initialize with the dependency
//    init(client: NetworkManager) {
//        self.client = client
//    }
//
//    func fetchAllProdcts(completion:@escaping (Result<[ProductModel], Error>) -> ()) {
//        self.client.getTheProductsWithCombine()
//            .sink { resp in
//                switch resp {
//                case .failure(let error):
//                    print("Error - \(error.localizedDescription)")
//                    completion(.failure(error))
//                case .finished:
//                    print("Task finished - fetchAllProdcts - ProductsService")
//                }
//            } receiveValue: { items in
//                completion(.success(items))
//            }
//            .store(in: &client.cancellables)
//
//    }
//}
