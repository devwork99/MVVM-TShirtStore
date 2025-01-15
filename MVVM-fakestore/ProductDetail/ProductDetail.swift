//
//  ProductDetail.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 14/01/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI



struct ProductDetail : View {

    
    let prod : ProductViewModel
    
    //This means, the details view should expect and Order object somewhere else, whenever that updates, update the view.
    @EnvironmentObject var order : Order
    
    var body : some View {
        
        //ScrollView{
            
            
            VStack{
                
                ZStack (alignment:.bottomTrailing){
                    
                    //Rectangle()
                        //.fill(Color.red)
                    
                    //Image(systemName:"eraser")
                    WebImage(url:URL(string:prod.image) ?? URL(filePath: "placeholder"))
                        .resizable()
                        //.aspectRatio(contentMode:.fill)
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.width*0.50 )
                        .clipped()
                    
    
                    Text(prod.category)
                        .font(Font(UIFont.systemFont(ofSize: 20)))
                        .padding(8)
                        .foregroundColor(.white)
                        .shadow(radius:1)
                        .background {
                            Color(.black)
                        }
                        .offset(x:-5, y: -5)
                            
                }
                
                
                
//                Text(prod.title)
//                    .foregroundColor(.black)
//                    .font(Font(UIFont.systemFont(ofSize: 20)))
                    
                
                

                Text(prod.description)
                    .foregroundColor(.black)
                    .font(Font(UIFont.systemFont(ofSize: 20)))
                    .padding()
                    
                
                
                Button("Add to Order"){
                    order.add(item: prod)
                }
                .buttonStyle(.borderedProminent)
                
                
                Spacer()
            }
            .navigationTitle(prod.title)
            .navigationBarTitleDisplayMode(.inline)
        
        
        
        //}
    }
    
    
}





struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        //Text("Hello, world!")
        ProductDetail(prod:ProductViewModel(product:sampleProduct()))
    }
}

