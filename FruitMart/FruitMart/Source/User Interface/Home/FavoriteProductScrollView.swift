//
//  FavoriteProductScrollView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/20.
//

import SwiftUI

struct FavoriteProductScrollView: View {
    @EnvironmentObject private var store: Store
    @Binding var showingImage: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            title   // 뷰의 제목
    
            if showingImage {
                products
            }
            
        } .padding()
            .transition(.slide)
    }
    
    var title: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("즐겨찾는 상품")
                .font(.headline).fontWeight(.medium)
            
            Symbol("arrowtriangle.up.square")
                .padding(4)
                .rotationEffect(Angle(radians: showingImage ? .pi : 0)) // 즐겨찾기 목록을 숨기고 펼칠 때에 아이콘들 회전시킴
            
            Spacer()
        }.padding(.bottom, 4)
            .onTapGesture {
                withAnimation {
                    self.showingImage.toggle()      // 이미지 표시 여부 변경
                }
            }
    }
    
    
    
    var products: some View {
        let favoriteProducts = store.products.filter { $0.isFavorite }
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(favoriteProducts){ product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        self.eachProduct(product)
                    }
                }
            }
        }.animation(.spring(dampingFraction: 0.78))
    }
    
    
    func eachProduct(_ product: Product) -> some View {
        GeometryReader {
            ResizedImage(product.imageName, renderingMode: .original)
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .scaleEffect(self.scaledValue(from: $0))
                .padding(.top, 1)
        }.frame(width: 105, height: 105)
    }
    
    
    func scaledValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16 // 글로벌 좌표 기준으로 상품의 x값을 구하고, 그 값에 적용된 여백 값만큼 빼주면 한 contentOffset 얻을 수 있음.
        
        let minSize: CGFloat = 0.8
        let maxSize: CGFloat = 1.0
        let delta: CGFloat = maxSize - minSize
        
        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
        
        return max(min(size, maxSize), minSize)
    }
    
    
}

//
//struct FavoriteProductScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteProductScrollView(showingImage: showingImage)
//    }
//}
//
