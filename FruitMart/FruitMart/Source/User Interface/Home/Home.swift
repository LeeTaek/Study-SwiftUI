//
//  ContentView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    @State private var quickOrder: Product?
    @State private var showingFavoriteImage: Bool = true
    
    var body: some View {
        
        NavigationView{
            VStack {
                if showFavorite {
                    favoriteProducts
                }
                darkerDivider
                productList
            }
        }
      
    }
    
    
    var favoriteProducts : some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
            .padding(.top, 24)
            .padding(.bottom, 8)
    }
    
    var darkerDivider: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
    
    var productList: some View {        // body에 작성되어 있던 기존 코드 추출
        List(store.products) { product in
            NavigationLink(destination: ProductDetailView(product: product)){
                ProductRow(quickOrder: self.$quickOrder, product: product)
            }
        }.buttonStyle(PlainButtonStyle())   //네비게이션보다 좋아요 버튼에 우선권을 줌.
        .navigationTitle("과일마트")
        
    }
    
    var showFavorite: Bool {
        !store.products.filter({ $0.isFavorite }).isEmpty
    }
    
    
    
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(Store())
            .previewInterfaceOrientation(.portrait)
    }
}
