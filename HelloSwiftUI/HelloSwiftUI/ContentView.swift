//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI
import CoreData


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
    var body: some View {
        Superview().environmentObject(User())   //1
    }
    
}

struct Superview: View {
    var body: some View {
        Subview()
    }
    
}
struct Subview: View {
    @EnvironmentObject var user: User
    var body: some View {
        Text(user.name.description) //2
        
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
