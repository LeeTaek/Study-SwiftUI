//
//  ContentView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

struct Home: View {
    let store: Store
    
    var body: some View {
        
        NavigationView{
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)){
                    ProductRow(product: product)
                }
            }.navigationTitle("과일마트")
            
        }
      
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(store: Store())
            .previewInterfaceOrientation(.portrait)
    }
}
