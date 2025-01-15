//
//  CheckoutView.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 15/01/2025.
//

import SwiftUI


struct CheckoutView : View {
    
    @EnvironmentObject var order : Order
    
    let paymentOptions = ["Cash", "Credit Card", "App Points"]
    
    //to keep the selection just for the current view, segments, make it private
    @State private var paymentType = "Cash"
    
    
    @State private var addLoyalityCard = false
    @State private var loyalityCardNumber = ""
    
    
    let tipOptions = ["10", "15", "20", "25", "0"]
    
    @State private var selectedTipOption = "15"
    
    
    var body: some View {
        Form {
            
            Section{
                
                
                
                //Swift @State property wrapper uses $ sign is for two way binding, between selection of payment types
                Picker("How to you want to Pay?", selection: $paymentType) {
                    ForEach(paymentOptions, id:\.self) { item in
                        Text(item)
                    }
                }
                
                Toggle("Do you want to Add you Loyality Card", isOn: $addLoyalityCard)
                
                if addLoyalityCard{
                    TextField("Loyality Card Number", text: $loyalityCardNumber)
                }
            }
            
            Section("Add a Tip?") {
                
                Picker("Percentage:", selection: $selectedTipOption) {
                    ForEach(tipOptions, id:\.self) { option in
                        Text("\(option)%")
                    }
                }
                .pickerStyle(.segmented)
                
            }
            
            Section ("Total : $100"){
                Button("Confirm Order") {
                    //place the order here.
                }
            }
            
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
