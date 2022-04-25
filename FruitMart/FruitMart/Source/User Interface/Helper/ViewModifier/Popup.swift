//
//  Popup.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/15.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}

fileprivate struct Popup<Message: View>: ViewModifier {
    let size: CGSize?        // 팝업창 크기
    let style: PopupStyle   //팝업 스타일
    let message: Message
    
    init(
        size: CGSize? = nil,
        style: PopupStyle = .blur,
        message: Message
    ) {
        self.size = size
        self.style = style
        self.message = message
    }
    
    
    func body(content: Content) -> some View {
        content // 팝업창을 띄운 뷰
            .blur(radius: style == .blur ? 2 : 0)   //  style이 블러인 경우 적용
            .overlay(Rectangle()                    //  dimmed 스타일인 경우 적용
                .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)), alignment: .center)
            .overlay(popupContent)
    }
    
    
    
    private var popupContent: some View {
        GeometryReader {
            VStack { self.message }
                .frame(width: self.size?.width ?? $0.size.width * 0.6, height: self.size?.height ?? $0.size.height * 0.25)
                .background(Color.primary.colorInvert())
                .cornerRadius(12)
                .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
                .overlay(self.checkCircleMark, alignment: .top)
                .position(x: $0.size.width / 2, y: $0.size.height / 2)

        }
    }
    
    // 팝업 창 상단에 위치한 체크마크 심벌
    private var checkCircleMark: some View {
        Symbol("checkmark.circle.fill", color: .peach)
            .clipShape(Circle())
            .font(Font.system(size: 60).weight(.semibold))
            .background(Color.white.scaleEffect(0.7))
            .offset(x: 0, y: -20)
    }
}


fileprivate struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isPresented)      // disabled에 전달된 값이 true라면 터치 등의 모든 상호작용을 무시.
                                        // 이는 팝업이 열려있는 동안 뒤로가기나 주문하기 같은 이벤트 발생을 차단하고 onTapGesture만 인식하게 한다.
            .onTapGesture {
                self.isPresented.toggle()
            }
    }
}


fileprivate struct PopupItem<Item: Identifiable>: ViewModifier {
    @Binding var item: Item?        // nil이 아니면 팝업 표시
    
    func body(content: Content) -> some View {
        content
            .disabled(item != nil)      // 팝업 떠있는 동안 상호작용 비활성
            .onTapGesture {
                self.item = nil         // 팝업창 제거
            }
    }
}



extension View {
    func popup<Content: View>(
        isPresented: Binding<Bool>,     // 뷰에서 전달해주는 원천 자료와 연동
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: () -> Content     // @ViewBuilder를 적용해 뷰를 좀 더 쉽게 추가
    ) -> some View {
        if isPresented.wrappedValue {   // isPresent는 Binding<Bool>이라 wrappedValue를 통해 접근해야함.
            let popup = Popup(size: size, style: style, message: content())
            let popupToggle = PopupToggle(isPresented: isPresented)
            let modifiedContent = self.modifier(popup).modifier(popupToggle)
               // 두개의 modifier을 중첩
            
            return AnyView(modifiedContent)     // 반환 타입이 불투명 타입의 특성을 만족해야함. 때문에 AniView 타입으로 반환
        } else {
            return AnyView(self)
        }
        
    }
    
    
    func popup<Content: View, Item: Identifiable>(
        item: Binding<Item?>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        if let seletedItem = item.wrappedValue {        // nil 아니면 팝업창 띄움
            let content = content(seletedItem)
            let popup = Popup(size: size, style: style, message: content)
            let popupItem = PopupItem(item: item)
            let modifiedContent = self.modifier(popup).modifier(popupItem)
            
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
        
    }
    
    
    
    func popupOverContext<Item: Identifiable, Content: View>(
      item: Binding<Item?>,
      size: CGSize? = nil,
      style: PopupStyle = .none,
      ignoringEdges edges: Edge.Set = .all,
      @ViewBuilder content: (Item) -> Content
    ) -> some View  {
      let isNonNil = item.wrappedValue != nil
      return ZStack {
        self
          .blur(radius: isNonNil && style == .blur ? 2 : 0)
        
        if isNonNil {
          Color.black
            .luminanceToAlpha()
            .popup(item: item, size: size, style: style, content: content)
            .edgesIgnoringSafeArea(edges)
        }
      }
    }
    
    
}





