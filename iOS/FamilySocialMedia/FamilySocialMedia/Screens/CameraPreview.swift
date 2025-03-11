//
//  CameraPreview.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//
import SwiftUI

struct CameraPreview: View {

    @Binding var image: CGImage?

    var body: some View {

        GeometryReader { geometry in
            if let image = image {
                Image(decorative:  image, scale: 1, orientation: .right)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
            }
            else {
                ContentUnavailableView("No Camera feed", systemImage: "xmark.circle.fill")
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
            }
        }
    }
}
