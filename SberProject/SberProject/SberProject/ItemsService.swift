//
//  ItemsService.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 06.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//
import UIKit

class ItemsService {
    static var shared: ItemsService = {
        let instance = ItemsService()
        
        return instance
    }()
    
    public var items: [Items] = []
    public var singleItem = [SingleItem]()
    public var imageData = Data()
}
