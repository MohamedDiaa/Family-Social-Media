//
//  CreatePostScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-14.
//

import Foundation
import SwiftUI

struct CreatePostScreen: View {

    @State var imgSelected: UIImage? = nil
    @State var showCamera: Bool = true
    var body: some View {

        if let img = imgSelected {

            VStack {

                HStack(spacing: 10) {

                    Button {
                        CloudinaryHelper.shared.upload(image: img)

                    } label: {
                        Text("Upoad")
                    }


                    Button {
                        imgSelected = nil
                    } label: {
                        Text("Camera")
                    }

                }

                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }
        }
        else {
            CameraScreen(image: $imgSelected)
        }
    }
}

#Preview {
    CreatePostScreen(imgSelected: nil)
}
