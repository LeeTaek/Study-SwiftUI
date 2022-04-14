//
//  Product.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

struct Product: Decodable {
//    let id : UUID = UUID()
    var id: String { name }
    
    let name: String
    let imageName: String
    let price: Int
    let description: String
    var isFavorite: Bool = false
}

extension Product: Identifiable {}

let productSamples = [
    Product(name: "나는 무화과", imageName: "fig", price: 3100, description: "소화가 잘되고 변비에 좋은 달달한 무화과! 고기와 찰떡궁합 ~"),
    Product(name: "유기농 아보카도", imageName: "avocado", price: 2900, description: "미네랄도 풍부, 장식과 소스로 좋은 아보카도!"),
    Product(name: "바나나 안바나나", imageName: "banana", price: 2400, description: "달콤한 맛의 바나나, 안바나나?!", isFavorite: true),
    Product(name: "파인애플 아니라 아나나스", imageName: "pineapple", price: 3000, description: "파인애플의 원어는 아나나스! 아나나스 아나나스! "),
    Product(name: "시원한 수박", imageName: "watermelon", price: 3500, description: "달콤시원한 하우스 수박!", isFavorite: true)

]
