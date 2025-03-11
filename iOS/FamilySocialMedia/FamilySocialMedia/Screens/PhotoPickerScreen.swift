//
//  PhotoPickerScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI
import PhotosUI

struct PhotoPickerScreen: View {

    @State private var selectedItem: PhotosPickerItem?
    @State var processedImage: Image?

    var body: some View {

        PhotosPicker(selection: $selectedItem) {

            if let processedImage {
                VStack {
                    processedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)

                    Text("Please edit this image")
                }
            } else {
                ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
            }

        }
        .onChange(of: selectedItem, loadImage)

    }

    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Image.self)
            else { return }
            processedImage = imageData
            // more code to come
        }
    }
}



#Preview {
    PhotoPickerScreen()
}
