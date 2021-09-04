//
//  TCANavigationPushPopApp.swift
//  TCANavigationPushPop
//
//  Created by Prasath Srithar on 24/08/2021.
//

import SwiftUI

@main
struct TCANavigationPushPopApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(initialState: ParentState(),
                                     reducer: appReducer,
                                     environment: AppEnvironment()
            )
            )
        }
    }
}
