//
//  ContentView.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct ContentView: View {
    @State var imgSelected: UIImage?

    var body: some View {

        TabView {

            HomeScreen(image: $imgSelected)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            PhotoPickerScreen()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Pick")
                }
            CameraScreen(image: $imgSelected)
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
