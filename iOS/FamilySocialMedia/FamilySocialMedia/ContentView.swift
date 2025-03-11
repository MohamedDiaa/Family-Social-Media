//
//  ContentView.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        TabView {

            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            PhotoPickerScreen()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Pick")
                }
            CameraScreen()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
        }
    }
}

#Preview {
    ContentView()
}
