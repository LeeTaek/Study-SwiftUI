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
            }.buttonStyle(PlainButtonStyle())   //네비게이션보다 좋아요 버튼에 우선권을 줌.
                .navigationTitle("과일마트")
        }
        .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))

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
        
        List() {
            ForEach(store.products) { product in
                HStack {
                    ProductRow(product: product, quickOrder: self.$quickOrder)
                    NavigationLink(destination: ProductDetailView(product: product)){
                        EmptyView()
                    }.frame(width:0)


                }
                .listRowBackground(Color.background)
                
            }
          
        }
    }
    
    var showFavorite: Bool {
        !store.products.filter({ $0.isFavorite }).isEmpty
        && store.appSetting.showFavoriteList
    }
    
    func popupMessage(product: Product) -> some View {
      let name = product.name.split(separator: " ").last!
      return VStack {
        Text(name)
          .font(.title).bold().kerning(3)
          .foregroundColor(.peach)
          .padding()
        
          OrderCompleteMessage()
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
