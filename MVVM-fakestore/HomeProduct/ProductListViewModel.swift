//
//  ProductListViewModel.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import Foundation
import Combine


//marked ObservableObject, so its accessible inside ContentView and we can observe the ViewModel.
//lets assing everything on MainQueue

@MainActor
class ProductListViewModel : ObservableObject {
    
    
    var cancellables = Set<AnyCancellable>()
    
    
    //dependency injection method, this makes testing easier
    
    let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    //define a property to hold the fetched products to pass on to another view
    
    //lets Publish the products and error, so view can Observe these 2
    @Published var products : [ProductViewModel] = []
    @Published var error : String = ""
    
    @Published var isLoading = false
    
    /*
    func populateProducts() async {
        self.isLoading = true
        do {
            let prods = try await webService.getAllProducts()
            self.products = prods.map(ProductViewModel.init)
            print("All Products == \(self.products)")
            self.isLoading = false
            
        } catch let error {
            print(error)
            //self.isLoading = false
        }
    }
    */
    
    //view model converts or changes the data that is more presentable to the view
    //with combine
    func populateTheProducts() {
        
        //the difference between 2 different implementation is that,
        // first implementation is with NetworkClient is inside the view model, can't be tested
        //with second approach is more sutable for POP-Testing (Protocol Oriented Programming)
        //separating the services in separate PROTOCOLS-CLASS means we can test them better, one by one
        
        self.isLoading = true
        
        networkManager.fetchProductsWithCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Some Error \(error.localizedDescription)")
                    self.isLoading = false
                case .finished :
                    print("Task finished")
                    self.isLoading = false
                }
            } receiveValue: { items in
                self.products = items.map(ProductViewModel.init)
            }
        
            .store(in:&self.cancellables)
        
        
        //with products service
        /*
        prodcutsService.fetchAllProdcts { [weak self] res in
            guard let self = self else {return}
            switch res {
            case .success(let items):
                print("items == \(items)")
                //data is converted to presentable to the view
                self.products = items.map(ProductViewModel.init)
                self.isLoading = false
            case .failure(let error):
                print("Error  - \(error.localizedDescription)")
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
        */
        
    }
    
}


struct ProductViewModel : Identifiable , Hashable{
    
    static func == (lhs: ProductViewModel, rhs: ProductViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id =  UUID()
    
    private var product : ProductModel
    
    init(product: ProductModel) {
        self.product = product
    }
        
    var title : String {
         product.title
    }
    
    var price:Double {
        product.price
    }
    
    var thumb: String {
        product.image
    }
    
    var description : String {
        product.description
    }
    
    var category : String {
        product.category
    }
    
    var image : String {
        product.image
    }
}
