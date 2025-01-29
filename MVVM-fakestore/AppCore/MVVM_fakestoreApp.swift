//
//  MVVM_fakestoreApp.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import SwiftUI

@main
struct MVVM_fakestoreApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            
            //environmentobject is SwiftUI way of sharing data in many parts of the application.
            //As the navigationstack pushes, the following views also gets access to the Order
            //ContentView()
            MainView()
                .environmentObject(order)
            //CoreDataBootCamp()
            //CoreDataRelationshipBootCamp()
            //NavigationStackBootCamp()
        }
    }
}
