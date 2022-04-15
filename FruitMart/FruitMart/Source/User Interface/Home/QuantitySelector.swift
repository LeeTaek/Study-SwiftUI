//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/14.
//

import SwiftUI

struct QuantitySelector: View {
    
    @Binding var quantity: Int
    var range: ClosedRange<Int> = 1...20    //수량 선택 가능 범위
    
    // 햅틱 비드백
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        HStack {
            Button(action: { self.changeQuantity(-1) }) {
                Image(systemName: "minus.circle.fill")
                    .imageScale(.large)
                    .padding()
            } .foregroundColor(Color.gray.opacity(0.5))
            
            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)
            
            Button(action: { self.changeQuantity(1) }) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .padding()
            } .foregroundColor(Color.gray.opacity(0.5))
            
        }
    }
    
    
    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedback.prepare()      // 진동 지연 시간을 줄일 수 있도록 미리 준비시키는 메서드
            softFeedback.impactOccurred(intensity: 0.8)
        } else {
            // 정해진 수량(1~20)을 벗어날 때에 강한 진동을 발생
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
        }
    }
    
}

struct QuantitySelector_Previews: PreviewProvider {
  
    static var previews: some View {
        Group {
            // 여기서 constant는 전달한 값을 Binding 타입으로 바꾸어 반환한다.
            QuantitySelector(quantity: .constant(1))
            QuantitySelector(quantity: .constant(10))
            QuantitySelector(quantity: .constant(20))
        }
        .padding()
        .previewLayout(.sizeThatFits
        )
        
    }
}
