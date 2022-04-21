//
//  Stripes.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/21.
//

import SwiftUI

struct Stripes: Shape {
    var stripes: Int = 30
    var insertion: Bool = true  // 삽입 제거 효과
    var ratio: CGFloat  // 화면 차지 비율
  
    var animatableData: CGFloat {
        get { ratio }
        set { ratio = newValue }
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 줄무늬 하나 너비
        let stripeWidth = rect.width / CGFloat(stripes)
        let rects = (0..<stripes).map { (index: Int) -> CGRect in
            
            let xOffset = CGFloat(index) * stripeWidth
            
            let adjustment = insertion ? 0 : (stripeWidth * ( 1 - ratio))
            
            return CGRect(
                x: xOffset + adjustment,
                y: 0,
                width: stripeWidth * ratio,
                height: rect.height
            )
        }
        path.addRects(rects)
        return path
    }
    
    
}

//extension AnyTransition {
//    static func modifier<E>(active: E, idntity: E) -> AnyTransition where E: ViewModifier
//}
//
//struct Stripes_Previews: PreviewProvider {
//    static var previews: some View {
//        Stripes()
//    }
//}

extension Stripes: Hashable {}
