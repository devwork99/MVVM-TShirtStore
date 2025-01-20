//
//  TabView.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 15/01/2025.
//

import SwiftUI


struct MainView : View {
    
    var body: some View {
        TabView {
            
            ContentView()
                .tabItem {
                    Label("List", systemImage:"list.dash")
                }
            
            
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "square.and.pencil")
                }
            
            CoreDataBootCamp()
                .tabItem {
                    Label("Store", systemImage:"storefront.fill")
                }
            
        }
    }
    
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        //Text("Hello, world!")
        MainView()
            .environmentObject(Order())
    }
}
