//
//  Order.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 15/01/2025.
//

import SwiftUI



//these are video series, Paul Hudson, for this short Swift App
//https://www.youtube.com/watch?v=bFwyDUhWXQ8
//ObserableObject protocols, knows any views that are watching
class Order : ObservableObject{
    
    
    //when the property changes, send the announcements to all the watchers/observers
    
    @Published var items = [ProductViewModel]()
    
    
    var total : Double {
        
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        }else{
            return 0
        }
    }
    
    
    func add(item:ProductViewModel){
        items.append(item)
    }
    
    func remove(item:ProductViewModel){
        if let indx = items.firstIndex(of: item) {
            items.remove(at: indx)
        }
    }
    
    
    
}
