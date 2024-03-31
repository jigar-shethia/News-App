//
//  News_AppApp.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//

import SwiftUI

@main
struct News_AppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NewsScreen()
        }
    }
}
