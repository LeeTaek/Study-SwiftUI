//
//  MainTablView.swift
//  FruitMart
//
//  Created by 이택성 on 2022/04/20.
//

import SwiftUI

struct MainTablView: View {
    private enum Tabs {
        case home, recipe, gallery, myPage
    }
    
    @State private var selectedTab: Tabs = .home        // 기본값 = 홈
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group{
                home
                recipe
                imageGallery
                myPage
            }
            .accentColor(.primary)
        }.accentColor(.peach)
            .edgesIgnoringSafeArea(.top)
            .statusBar(hidden: selectedTab == .recipe)

    }
}


private extension MainTablView {
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
            .onAppear{ UITableView.appearance().separatorStyle = .none }
    }
    
    var recipe: some View {
        RecipeView()
            .tag(Tabs.recipe)
            .tabItem(image: "book", text: "레시피")
    }
    
    var imageGallery: some View {
        ImageGallery()
            .tag(Tabs.gallery)
            .tabItem(image: "photo.on.rectangle", text: "갤러리")
    }
    
    var myPage: some View {
        Text("마이페이지")
            .tag(Tabs.recipe)
            .tabItem(image: "person", text: "마이페이지")
    }
}

fileprivate extension View {
    func tabItem(image: String, text: String)  -> some View {
        self.tabItem {
            Symbol(image, scale: .large)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}



struct MainTablView_Previews: PreviewProvider {
    static var previews: some View {
        MainTablView()
    }
}
