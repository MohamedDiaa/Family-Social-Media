//
//  CameraScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI
import PhotosUI

struct CameraScreen: View {
    @State var selectedImage: PhotosPickerItem?

    var body: some View {
        VStack {
            Text("CameraScreen")

            Button {

            } label: {
                Text("Take Photo")
            }
        }
    }
}



#Preview {
    CameraScreen()
}
