//
//  ReceiptItem.swift
//  Pay With Friends
//
//  Created by Charles on 2/9/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import Foundation

class ReceiptItem {
    
    let id: String
    let name: String
    let price: Float
    
    init(id: String, name: String, price: Float) {
        self.id = id
        self.name = name
        self.price = price
    }
    
}
