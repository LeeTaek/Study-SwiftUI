//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/14.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    @State private var quantity: Int = 1
    @State private var showingAlert: Bool = false
    @State private var showingPopup: Bool = false
    @State private var willApear: Bool = false

    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack(spacing: 0) {
            if willApear {
                productImage
            }
            orderView
        }
        .popup(isPresented: $showingAlert) {
            OrderCompleteMessage()
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingPopup) {
                confirmAlert
            }
        .onAppear{ self.willApear = true }
    }
    
    
    
    
    
    // 이미지 뷰
    var productImage: some View {
        let effect = AnyTransition.scale.combined(with: .opacity).animation(Animation.easeInOut(duration: 0.4).delay(0.05))
        
        return GeometryReader { _ in
            ResizedImage(self.product.imageName)
        }.transition(effect)
    }
    
    
    
    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription
                Spacer()
                self.priceInfo
                self.placeOrderButton
            }
            .padding(32)
            .frame(height: $0.size.height + 10)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }
    
    
    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(product.name)
                    .font(.largeTitle).fontWeight(.medium).foregroundColor(.black)
                
                Spacer()
                
               FavoriteButton(product: product)
            }
            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()
           
        }
    }
    
    // 가격
    var priceInfo: some View {
        let price = quantity * product.price
        
        return HStack { (Text("￦")
         + Text("\(price)").font(.title)
        ).fontWeight(.medium)
            Spacer()
        
        QuantitySelector(quantity: $quantity)
            
        // 수량 버튼
        } .foregroundColor(.black)
    }

    // 주문 버튼
    var placeOrderButton: some View {
        Button(action: { self.showingAlert = true }) {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                    .font(.system(size: 20)).fontWeight(.medium)
                    .foregroundColor(Color.white))
                .padding(.vertical, 20)
        }.buttonStyle(ShrinkButtonStyle())
    }
    
    // 화면에 출력할 설명창 글 분할
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }
        
        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
        ?? text[centerIdx...].firstIndex(of: " ")
        ?? text.index(before: text.endIndex)
        
        let afterSpaceIdx = text.index(after: centerSpaceIdx)
        let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
        
        return String(lhsString + "\n" + rhsString)
    }
    
        
    // 알림창에 표시할 내용
    var confirmAlert: Alert {
        Alert(title: Text("주문 확인"),
              message: Text("\(product.name)을(를) \(quantity)개 구매하시겠습니까?"),
              primaryButton: .default(Text("확인"), action: {
            self.placeOrder()
            print(store.orders)
        }),
              secondaryButton: .cancel(Text("취소")))
    }
    
    // 상품 수량과 정보를 placeOrder에 전달
    func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
        showingPopup = true
    }
}
        


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[0])
            .previewInterfaceOrientation(.portrait)
    }
}


