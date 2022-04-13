//
//  HelloSwiftUIApp.swift
//  HelloSwiftUI
//
//  Created by 이택성 on 2022/04/13.
//

import SwiftUI

@main
struct HelloSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
