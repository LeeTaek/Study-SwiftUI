//
//  AnyTransitionExtension.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/21.
//

import SwiftUI

extension AnyTransition {
    static func stripes() -> AnyTransition {
        func stripesModifier(
            stripes: Int = 30,
            insertion: Bool = true,
            ratio: CGFloat
        ) -> some ViewModifier {
            let shape = Stripes(stripes: stripes, insertion: insertion, ratio: ratio)
        
            return ShapeClipModifier(shape: shape)
        }
        
        let insertion = AnyTransition.modifier(active: stripesModifier(ratio: 0), identity: stripesModifier(ratio: 1))
        let removal = AnyTransition.modifier(active: stripesModifier(insertion: false, ratio: 0), identity: stripesModifier(insertion: false, ratio: 1))
    
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
    
    
}
