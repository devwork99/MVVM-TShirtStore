//
//  ProductListViewModel.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import Foundation



//marked ObservableObject, so its accessible inside ContentView
//lets assing everything on MainQueue

@MainActor
class ProductListViewModel : ObservableObject {
    
    
    //dependency injection method, this makes testing easier
    
    let webService : WebService
    
    init(webService : WebService){
        self.webService = webService
    }
    
    
    //define a property to hold the fetched products to pass on to another view
    
    @Published var products : [ProductViewModel] = []
    
    
    @Published var isLoading = false
    
    
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
