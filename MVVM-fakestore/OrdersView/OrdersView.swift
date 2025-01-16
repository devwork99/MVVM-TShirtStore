//
//  OrdersView.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 15/01/2025.
//

import SwiftUI


struct OrdersView : View {
    
    //Access the order class somewhere else
    @EnvironmentObject var order : Order
    
    
    
    var body: some View {
        
        
        NavigationStack{
            
            List {
                
                Section {
                    ForEach(order.items) { item in
                        HStack{
                            Text("\(item.title)")
                                .lineLimit(1)

                            Spacer()
                            
                            Text(String(format:"%.1f", item.price))
                        }
                    }
                    .onDelete(perform:deleteItems)
                }
                
                Section{
                    NavigationLink("Place Order"){
                        //Text("Checkout")
                        CheckoutView()
                    }
                }
                .disabled(order.items.isEmpty)
            }
            
            
    
            .navigationTitle("Orders")
            .toolbar {
                EditButton()
            }
    
        }
        //Text("These are all the orders list")
    }
    
    func deleteItems(at offSets:IndexSet){
        order.items.remove(atOffsets: offSets)
    }
}



struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
            .environmentObject(Order())
    }
}

