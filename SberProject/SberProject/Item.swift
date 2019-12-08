//
//  Item.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 06.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

struct JSData : Codable {
    let data:[Items]
}

struct Items : Codable {
    let id: String
    let price : Int
    let title: String
    let url: String
}

struct JSSingleData: Codable {
    var data:SingleItem
}

struct SingleItem: Codable {
    var brand: String
    var description: String
    var id: String
    var link: String
    var price: Int
}
