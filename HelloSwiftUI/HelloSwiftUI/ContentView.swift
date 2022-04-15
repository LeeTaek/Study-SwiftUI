//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI


class User: ObservableObject {
    //  ObservableObject는 뷰 외부 모델에 의존성을 가진다.
    let name = "User Name"
    // @published가 없을 경우 화면이 동작하지 않는다.
    // 어떤 값이 바뀌었을때에 뷰를 갱신해야하는지 모르기 때문.
    // 이를 알려주는 것이 @Published이다. 이는 값이 바뀐 즉시 화면이 갱신된다.
    @Published var score = 0
    
//     objectWillChange로 뷰 갱신 시점을 정할수도 있다.
//     다음은 @published와 똑같이 동작한다.
//    var score = 0 {
//        willSet { objectWillChange.send() }
//    }
//
}

struct ContentView: View {
    @State private var isOn  = true

    
    var body: some View {
            
        VStack(spacing: 20) {
            Button("커스텀버튼 스타일1") {}
                .buttonStyle(CustomprimitiveButtonStyle())
            
            Button("커스텀버튼 스타일2") {}
                .buttonStyle(CustomprimitiveButtonStyle(minimumDuration: 1))
            
            Toggle("기본토글", isOn: $isOn)
            
            Toggle("커스텀 토글", isOn:  $isOn)
                .toggleStyle(CustomToggleStyle())
        }
    }
    
}

    
struct CustomprimitiveButtonStyle: PrimitiveButtonStyle {
    var minimumDuration = 0.5 //     기본값 0.5초
    
    func makeBody(configuration: Configuration) -> some View {
        
        ButtonStyleBody(conficuration: configuration, minumumDuration: minimumDuration)
    }
    
    private struct ButtonStyleBody: View {
        let conficuration: Configuration
        let minumumDuration: Double
        // @GestureState는 동작하는 순간에만 값이 변하고 종료되면 다시 초기값으로 돌아간다.
        @GestureState private var isPressed = false
        
        var body: some View {
            
            // LongPressGesture가 인식하기 까지의 최소 시간
            // value는 버튼을 누르는지 여부를 전달, 이 값이 state에 저장되면 state의 상태는 isPressed에 저장된다.
            // 저장시간 동안 눌리면 onEnded 이벤트가 발생
            let longPress = LongPressGesture(minimumDuration: minumumDuration).updating($isPressed) { value, state, _ in
                state = value
            }.onEnded { _ in
                self.conficuration.trigger()
            }
            
            return conficuration.label
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                .scaleEffect(isPressed ? 0.8 : 1.0)
                .opacity(isPressed ? 0.6 : 1.0)
                .gesture(longPress)
            
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    let size: CGFloat = 30
    
    // makeBody 메서드를 통해 구현
    func makeBody(configuration: Configuration) -> some View {
        let isOn = configuration.isOn
        return HStack{
            configuration.label         // 토글의 사용 용도를 표시하기 위한 뷰
            
            Spacer()
            
            ZStack(alignment: isOn ? .top : .bottom) {
                Capsule()
                    .fill(isOn ? Color.green : Color.red)
                    .frame(width: size, height: size * 2)
                
                Circle()
                    .frame(width: size - 2, height: size - 2)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
