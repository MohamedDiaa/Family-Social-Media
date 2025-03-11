//
//  CameraScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI
import PhotosUI

struct CameraScreen: View {


    @State private var selectedItem: PhotosPickerItem?
    @State var processedImage: Image?

    var body: some View {

        PhotosPicker(selection: $selectedItem) {

            if let processedImage {
                VStack {
                    processedImage
                        .resizable()
                        .scaledToFit()

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
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            processedImage = Image.init(uiImage: inputImage)
            // more code to come
        }
    }
}



#Preview {
    CameraScreen()
}
