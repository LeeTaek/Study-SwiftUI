//
//  ContentView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            ProductRow()
            ProductRow()
            ProductRow()

        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
