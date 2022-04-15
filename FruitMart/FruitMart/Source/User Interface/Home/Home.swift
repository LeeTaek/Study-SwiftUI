//
//  ContentView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        
        NavigationView{
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)){
                    ProductRow(product: product)
                }
            }.buttonStyle(PlainButtonStyle())   //네비게이션보다 좋아요 버튼에 우선권을 줌.
            .navigationTitle("과일마트")
            
        }
      
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(Store())
            .previewInterfaceOrientation(.portrait)
    }
}
