//
//  Store.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/14.
//
import SwiftUI

final class Store {
    var products: [Product]
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
