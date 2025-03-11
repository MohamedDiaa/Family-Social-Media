//
//  CameraManager.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-11.
//
import Foundation
import AVFoundation

class CameraManager: NSObject {

    private let captureSession = AVCaptureSession()

    private var deviceInput: AVCaptureDeviceInput?

    private var photoOutput: AVCapturePhotoOutput?

    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)


    private var sessionQueue = DispatchQueue(label: "video.preview.session")

    private var isAuthorized: Bool {

        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)

            var isAuthorized = status == .authorized

            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }

            return isAuthorized
        }
    }

    private var addToPreviewStream: ((CGImage) -> Void)?

    lazy var previewStream: AsyncStream<CGImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()

    // 1.
    override init() {
        super.init()

        Task {
            await configureSession()
            await startSession()
        }
    }

    // 2.
    private func configureSession() async {
        // 1.
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera)
        else { return }

        captureSession.beginConfiguration()

        // 3.
        defer {
            self.captureSession.commitConfiguration()
        }

        // 4.
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)

        // 5.
        guard captureSession.canAddInput(deviceInput) else {
            print("Unable to add device input to capture session.")
            return
        }

        // 6.
        guard captureSession.canAddOutput(videoOutput) else {
            print("Unable to add video output to capture session.")
            return
        }

        // 7.
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)

    }

    // 3.
    private func startSession() async {
        /// Checking authorization
        guard await isAuthorized else { return }
        /// Start the capture session flow of data
        captureSession.startRunning()
    }}


extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else { return }
        addToPreviewStream?(currentFrame)
    }


}
