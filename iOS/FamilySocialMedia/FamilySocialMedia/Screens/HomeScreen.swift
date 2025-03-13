//
//  HomeScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct HomeScreen: View {

    @State var photos: [Photo]?

    var body: some View {

        ScrollView(.vertical) {
            VStack {
                Text("Hello, World!")


                if let photos {
                    ForEach(photos, id:\.photoId) { photo in

                        AsyncImage(url: photo.thumbnail) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 250, height: 250)
                    }
                }

            }
        }
        .task {
            photos = await NetworkManager().getPhotos()
        }
    }
}

#Preview {
    HomeScreen()
}
