//
//  NavigationStackBootCamp.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 14/01/2025.
//

import SwiftUI



struct NavigationStackBootCamp : View {
    
    
    //lets push three more screens of fruits
    
    private var fruits = ["Mango", "Apple", "Bnana"]
    
    
    var body: some View {
       
        
        //Text("This is Navigation Stack Boot Camp")
        
        NavigationStack {
                
            ScrollView {
                
                VStack(spacing:20) {
                    
                    
                    
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text("Click \(fruit)")
                        }
                    }
                    
                    
                    ForEach(0..<10) { count in
                       
                        NavigationLink(value: count) {
                            Text("Click Here \(count)")
                        }
                        
                        /*
                        NavigationLink(destination: {
                            
                            MySecondScreen(value:count)
                            
                        }, label: {
                            Text("Click Here \(count)")
                        })
                        */
                        
                        
                    }

                }
            }

            
            //title is inside the NavigationStack or NavigationView
            .navigationTitle("Navigation-list")
            
            .navigationDestination(for: Int.self) { value in
                MySecondScreen(value: value)
            }
            
            .navigationDestination(for: String.self) { value in
                //MySecondScreen(value: value)
                Text("Another Screen \(value)")
            }
        }
        
    }
}




struct NavigationStackBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootCamp()
    }
}


struct MySecondScreen : View {
    
    var value : Int
    
    init(value: Int) {
        self.value = value
        print("value == \(value)")
    }
    
    var body: some View {
        
            Text("This is screen number \(value)")
        
    }
}


