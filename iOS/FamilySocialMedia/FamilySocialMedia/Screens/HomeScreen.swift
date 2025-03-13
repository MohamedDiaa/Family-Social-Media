//
//  HomeScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//

import SwiftUI

struct HomeScreen: View {
    
    @Binding var image: UIImage?
    let cloudinary = CloudinaryHelper.shared

    var body: some View {
        VStack {
            Text("Hello, World!")

            if let image {


                Button {
                    cloudinary.upload(image: image)
                } label: {

                    Text("upload image")
                }


                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }
        }
    }
}

#Preview {
    HomeScreen(image: .constant(nil))
}
