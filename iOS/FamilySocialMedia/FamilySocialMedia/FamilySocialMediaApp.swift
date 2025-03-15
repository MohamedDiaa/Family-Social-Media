//
//  FamilySocialMediaApp.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI
import Observation

@main
struct FamilySocialMediaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(AudioPlayer())
        }
    }
}
