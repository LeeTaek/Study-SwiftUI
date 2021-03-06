//
//  ProductRow.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI


struct ProductRow: View {
    let product: Product

    @EnvironmentObject var store: Store
    @Binding var quickOrder: Product?
    @State private var willAppear: Bool = false
    
    
    
    var body: some View {
        HStack{
            productImage
            productDescription
           
        }
        .frame(height: store.appSetting.productRowHeight)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
        .opacity(willAppear ? 1 : 0)            // 애니메이션 추가
        .animation(.easeInOut(duration: 0.4), value: self.willAppear)
        .onAppear{ self.willAppear = true }
        .contextMenu{ contextMenu }
    }
}


private extension ProductRow {
    
    // 이미지 프로퍼티
    var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }

    // 제품 설명 프로퍼티
    var productDescription: some View {
        
        VStack(alignment: .leading) {
            // 상품 이름
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            
            // 상품 설명
            Text(product.description)
                .font(.footnote)
                .foregroundColor(Color.secondaryText)
            
            Spacer()
            
            footerView
            
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }


    // 가격 프로퍼티
    var footerView: some View {
        HStack(spacing: 0){
            Text("￦").font(.footnote)
            + Text("\(product.price)").font(.footnote)
            
            Spacer()
            
            FavoriteButton(product: product)
            
            Symbol("cart", color: .peach)
                .frame(width: 32, height: 32)
                .onTapGesture {
                    self.orderProduct()
                }
            
        }
    }
    
    var contextMenu: some View {
        VStack {
            Button(action: { self.toggleFavorite()}) {
                Text("Toggle Favorite")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            }
            
            Button(action: { self.orderProduct()}) {
                Text("Order Product")
                Symbol("cart")
            }
            
        }
        
    }
    
    
    func orderProduct() {
        quickOrder = product
        store.placeOrder(product: product, quantity: 1)
        
    }
    
    func toggleFavorite() {
        store.toggleFavorite(of: product)
    }
    
}



struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
//        ProductRow(quickOrder: .constant(nil), product: $0)
        ProductRow(product: productSamples[0], quickOrder: .constant(nil))

    }
}






