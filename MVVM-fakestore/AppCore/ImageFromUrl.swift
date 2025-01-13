//
//  ImageFromUrl.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import SwiftUI


struct ImageFromUrl : View {
    
    
    var url : String
    var placeHolder : String
    
    @ObservedObject var _imageLoader = ImageLoader()
    
    
    init(url:String, placeHolder:String = "placeholder"){
        self.url = url
        self.placeHolder = placeHolder
        
        self._imageLoader.downloadData(url:self.url)
    }
    
    
    var body: some View {
        
        if let haveData = _imageLoader.data {
            Image(uiImage: UIImage(data:haveData)!)
        }else{
            Image(placeHolder)
        }

    }
}

//------------------------------------------------------


class ImageLoader : ObservableObject {
    
    @Published var data: Data?
    //var url : String
    
    
//    init(data: Data? = nil, url: String) {
//        self.data = data
//        self.url = url
//    }
    
    
    func downloadData(url:String){
        
        guard let url = URL(string: url) else {
            print("Invalid url - ImageLoader")
            return
        }
        
        URLSession.shared.dataTask(with:URLRequest(url:url)) { data, _, error in
            
            guard let data = data, error != nil else {
                //print("error - \(error?.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
        
    }
    
    
}
//------------------------------------------------------




//struct ImagePreview : PreviewProvider {
//
//    static var previews: some View {
//        ImageFromUrl(url:"https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg")
//    }
//}


//struct URLImage_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageFromUrl(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
//    }
//}
