//
//  Store.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/14.
//
import SwiftUI

final class Store: ObservableObject {
    @Published var products: [Product]
    @Published var orders: [Order] = [] {
        didSet { saveData(at: orderFilePath, data: orders) }
    }
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
        self.orders = loadData(as: orderFilePath, type: [Order].self)
    }
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
        Order.lastOrderID = nextID
    }
    
}

//  즐겨찾기 정보 변경
extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { print("guard!: \(product)");  return }
        products[index].isFavorite.toggle()
    }

   
 
    var orderFilePath: URL {
            // Library 디렉터리에 있는  ApplicationSupport 디렉토리 URL
        let manager = FileManager.default
        let appSuportDir = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        //번들ID를 서브 디렉토리로 추가
        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        let appDir = appSuportDir.appendingPathComponent(bundleID, isDirectory: true)
    
        // 디렉토리 없으면 생성
        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir, withIntermediateDirectories: true)
        }
        
        return appDir
            .appendingPathComponent("Orders")
            .appendingPathExtension("json")
        
    }

    
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path)
             
        } catch {
            print(error)
        }
    }
    
    
    func loadData<T>(as path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path)
            let decodeData = try JSONDecoder().decode(type, from: data)
            return decodeData
        } catch {
            return []
        }
    }

}
