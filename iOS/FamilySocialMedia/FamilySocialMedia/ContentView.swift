//
//  ContentView.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct ContentView: View {

    @State var selected: Int = 1

    var body: some View {

        TabView(selection: $selected){

            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)

            PhotoPickerScreen()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Pick")
                }
                .tag(2)
            CreatePostScreen()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Post")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
