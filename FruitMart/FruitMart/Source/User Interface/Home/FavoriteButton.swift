//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/15.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject private var store: Store
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"
    }
    
    
    var body: some View {
        Button(action: { self.store.toggleFavorite(of: self.product)}) {
            Symbol(imageName, scale: .large, color: .peach)
                .frame(width: 32, height:  32)
                .onTapGesture {
                    withAnimation {
                        self.store.toggleFavorite(of: self.product)

                    }
                }
        }
        
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(product: productSamples[0])
    }
}
