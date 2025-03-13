//
//  CameraViewModel.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-12.
//
import SwiftUI
import Foundation
import AVFoundation

@Observable
class CameraViewModel {

    var currentFrame: CGImage?
    var isTaken = false
    var isSaved = false
    var position: AVCaptureDevice.Position = .back

    var cameraManager = CameraManager()

    init() {
        Task {
            await handleCameraPreviews()
        }
    }

    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
            }
        }
    }

    func takePic() {
        print("take pic")
        DispatchQueue.global(qos: .userInitiated).async{

            self.cameraManager.captureSession.stopRunning()

            DispatchQueue.main.async {

                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }

    func reTake() {
        DispatchQueue.global(qos: .userInitiated).async {

            self.cameraManager.captureSession.startRunning()

            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                    //  self.picData = nil
                    self.isSaved = false
                }
            }
        }
    }

    func savePic() {

        guard let currentFrame = currentFrame
        else { return }

        let image = UIImage.init(cgImage: currentFrame)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        self.isSaved = true
        print("saved successfully")
    }

    func switchCameraPosition() {
        position = position == .back ? .front : .back
        cameraManager.captureSession.stopRunning()
        cameraManager = CameraManager(position: position)
        Task {
            await handleCameraPreviews()
        }


    }
}
