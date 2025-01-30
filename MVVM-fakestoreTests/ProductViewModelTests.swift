//
//  ProductViewModelTests.swift
//  MVVM-fakestoreTests
//
//  Created by Muhammad Yasir on 28/01/2025.
//

import XCTest
import Combine
@testable import MVVM_fakestore //because app itself is a different target and code base

//dependency injection
//https://www.youtube.com/watch?v=E3x07blYvdE

//unit tests for this code base
//https://www.youtube.com/watch?v=eqdvIUKsM2A

//Naming Structure : test_[struct_or_class]_[variable_to_test]_[expected_result]

//Testing Structure : Given, When , Then

class ProductViewModelTests: XCTestCase {

    
    @MainActor func test_productListViewModel_products_greaterThanOne() {
        
        var cancellables = Set<AnyCancellable>()
        
        //Given
        let manager = NetworkManager()
        
        //When
        let vm = ProductListViewModel(networkManager:manager)
        //await vm.populateTheProducts()
        
        let expectation = XCTestExpectation(description:"fetched more than 1 Products")
    
        vm.$products
            .dropFirst()
            .sink{
                XCTAssertGreaterThan($0.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.populateTheProducts()
        wait(for: [expectation], timeout:5)
    }
    
}

