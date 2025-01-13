//
//  ContentView.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    
    //The @StateObject property wrapper is responsible for keeping the object alive throughout the life of the app.
    @StateObject private var vm : ProductListViewModel = ProductListViewModel(webService: WebService())
    
    
    var body: some View {
        VStack {
            
            List {
                ForEach(vm.products) { prod  in
                    
                    HStack {
                        
                        
                        //Image(uiImage: UIImage(data: Data(base64Encoded: prod.thumb)!)!)
                        
                        /*
                        Image(NSDataAssetName(contentsOf:URL(string:prod.thumb), usedEncoding: &UTF8))
                            .resizable()
                            .frame(width:30, height: 30)
                        */
                        
                        /*
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .frame(width:30, height:30)
                        */
                        
                        ImageFromUrl(url: prod.thumb)
                            .aspectRatio(contentMode:.fill)
                            .frame(width:50, height:50)
                            .clipped()
                            .padding()
                            
                        
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
            }.task {
                await vm.populateProducts()
            }
            
            
        }
        //.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
