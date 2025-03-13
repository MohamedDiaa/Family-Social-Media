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

                if let photos {
                    ForEach(photos, id:\.photoId) { photo in

                        AsyncImage(url: photo.thumbnail) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                        } placeholder: {
                            Color.gray
                        }
                        .padding(.horizontal)


                    }
                }
                else {
                    ContentUnavailableView("No Photos Found", systemImage: "figure.walk.triangle")
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
