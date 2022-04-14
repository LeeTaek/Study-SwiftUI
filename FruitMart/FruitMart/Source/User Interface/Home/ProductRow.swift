//
//  ProductRow.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI


struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack{
            productImage
            productDescription
           
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
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
            
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
        }
    }



    
    
}



struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productSamples[0])
    }
}






