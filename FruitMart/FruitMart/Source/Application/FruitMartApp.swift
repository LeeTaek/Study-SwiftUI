//
//  FruitMartApp.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

@main
struct FruitMartApp: App {
    var body: some Scene {
        WindowGroup {
            Home(store: Store())
        }
    }
}
