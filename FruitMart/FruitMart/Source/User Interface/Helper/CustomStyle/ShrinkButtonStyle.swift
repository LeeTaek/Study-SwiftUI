//
//  ShrinkButtonStyle.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/15.
//

import SwiftUI

// 커스텀 버튼 스타일
struct ShrinkButtonStyle: ButtonStyle {
    // 버튼이 눌리고 있을 때 변화할 크기와 투명도 지정
    var minScale: CGFloat = 0.9
    var minOpacity: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
    
    
}
