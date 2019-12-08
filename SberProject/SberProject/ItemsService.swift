//
//  ItemsService.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 06.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//


class ItemsService {
    static var shared: ItemsService = {
        let instance = ItemsService()
        
        return instance
    }()
    
    public var items: [Items] = []
    public var singleItem = [SingleItem]()
}
