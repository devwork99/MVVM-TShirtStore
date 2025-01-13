//
//  Image+Extension.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 13/01/2025.
//

import SwiftUI


extension Image {
    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
