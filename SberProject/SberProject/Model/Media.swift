//
//  Media.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 04.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/png"
        self.filename = "picture.png"
        //guard let data = image.pngData() else {return nil }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        self.data = data
    }
    
}
