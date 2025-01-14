//
//  ContentView.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
        
    //The @StateObject property wrapper is responsible for keeping the object alive throughout the life of the app.
    @StateObject private var vm : ProductListViewModel = ProductListViewModel(webService: WebService())
    
    var body: some View {
        
        
        ZStack {
            //To show a loader, you have to put it in a Zstack
            if vm.isLoading{
                ProgressView().progressViewStyle(.circular)
            }else{
                VStack {
                    List {
                        ForEach(vm.products) { prod  in
                            StoreMainList(prod: prod)
                        }
                    }
                }
            }
        }.task {
            //attach the task to ZStack
            await vm.populateProducts()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct StoreMainList : View {
    
    var prod : ProductViewModel
    
    var body: some View {
        
        HStack {
            
            WebImage(url:URL(string:prod.thumb))
                .resizable()
                .frame(width:50, height:50)
            
            
            Text(prod.title)
                .foregroundColor(Color(.black))
                .font(Font(UIFont.systemFont(ofSize:10)))
                .lineLimit(3)
            
            Text(String(format: "%.1f", prod.price) + "$")
                .foregroundColor(Color(.gray))
                .font(Font(UIFont.systemFont(ofSize:12)))
                .frame(maxWidth:.infinity, alignment:.trailing)
        }
        
    }
}
