//
//  CameraScreen-.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-12.
//
import SwiftUI
import AVFoundation

struct CameraScreen: View {

    @State private var viewModel = CameraViewModel()

    var body: some View {

        ZStack {

            CameraStreamPreview(image: $viewModel.currentFrame)

            VStack {

                HStack {
                    Spacer()

                    if viewModel.isTaken {

                        Button {
                            viewModel.reTake()

                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera")
                                .foregroundStyle(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing,10)
                    }
                    else {

                        Button {
                            viewModel.switchCameraPosition()
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                                .foregroundStyle(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)
                    }
                }

                Spacer()

                HStack {

                    if viewModel.isTaken {
                        Button {
                            if !viewModel.isSaved {
                                viewModel.savePic()
                            }

                        } label: {
                            Text(viewModel.isSaved ? "Saved" : "Save")
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.white)
                                .clipShape(Capsule())
                        }
                        .padding(.leading)

                        Spacer()

                    }
                    else {
                        Button {
                            viewModel.takePic()

                        } label: {

                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 65, height: 65)

                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 70, height: 70)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CameraScreen()
}


struct CameraStreamPreview: View {

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
