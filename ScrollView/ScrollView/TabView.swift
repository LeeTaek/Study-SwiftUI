//
//  TabView.swift
//  ScrollView
//
//  Created by 이택성 on 2022/04/20.
//

import SwiftUI

struct TabView: View {
    
    var body: some View {
        TabView {      // 콘텐츠로 자식의 뷰 전달
          
       
            Text("1번 탭").font(.largeTitle)
                .tabItem {
                Image(systemName: "house")
                Text("아이템 1")
            }
        
            Text("두번쨰 화면")
                .font(.title)
                .padding()
                .tabItem {
                    Image(systemName: "cube")
                    Text("아이텝 2")
                }
            
            SomeView()
                .tabItem {
                    Image(systemName: "person")
                    Text("아이템 3")
                }
            
        }
    }
}

struct SomeView: View {
    var body: some View {
        VStack {
            Text("실제로는")
            Text("이렇게 별도의 뷰를 만들어 사용")
        }.font(.title)
    }
}




struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
