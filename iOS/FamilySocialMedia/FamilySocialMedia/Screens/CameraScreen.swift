//
//  CameraScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct CameraScreen: View {

    @State private var viewModel = CameraViewModel()

    var body: some View {

        if(true) {
            CameraPreview(image: $viewModel.currentFrame)
        }
        else {
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
