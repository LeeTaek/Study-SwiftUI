//
//  Order.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/15.
//

import SwiftUI

struct Order: Identifiable {        // 식별을 위해 Identifiable 프로토콜 채택
    static var orderSequence = sequence(first: 1) { $0 + 1 }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
}



