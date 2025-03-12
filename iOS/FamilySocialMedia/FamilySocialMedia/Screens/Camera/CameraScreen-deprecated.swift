//
//  CameraScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-12.
//

import SwiftUI
import AVFoundation

struct CameraScreen2: View {

    @StateObject var camera = CameraModel()
    @State private var viewModel = CameraViewModel()

    var body: some View {

        ZStack {

            CameraStreamPreview(image: $viewModel.currentFrame)
          //  CameraPreview(camera: camera)
           //     .ignoresSafeArea(.all, edges: .all)

            VStack {

                if camera.isTaken {
                    HStack {
                        Spacer()

                        Button {
                            camera.reTake()

                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera")
                                .foregroundStyle(.blue)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing,10)
                    }
                }

                Spacer()

                HStack {

                    if camera.isTaken {
                        Button {
                            if !camera.isSaved {
                                camera.savePic()
                            }

                        } label: {
                            Text(camera.isSaved ? "Saved" : "Save")
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
                            camera.takePic()

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
        .onAppear {
            camera.check()
        }
    }
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {

    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var isSaved = false
    @Published var picData: Data? = Data.init(count: 0)
    var preview: AVCaptureVideoPreviewLayer!

    func check() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] status in
                if status {
                    self?.setUp()
                }
            }
        case .denied:
            alert.toggle()
        default:
            return
        }
    }

    func setUp() {

        do {
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!

            let input = try AVCaptureDeviceInput(device: device)

            if session.canAddInput(input) {
                session.addInput(input)
            }

            if self.session.canAddOutput(self.output) {
                session.addOutput(self.output)
            }

            self.session.commitConfiguration()

        }
        catch {
            print(error.localizedDescription)
        }

    }

    func takePic() {
        print("take pic")
        DispatchQueue.global(qos: .userInitiated).async{

            self.session.stopRunning()

            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            self.output.capturePhoto(with: settings, delegate: self)


            DispatchQueue.main.async {

                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }

    func reTake() {
        DispatchQueue.global(qos: .userInitiated).async {

            self.session.startRunning()

            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                    self.picData = nil
                    self.isSaved = false
                }
            }
        }
    }


    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        print("pic taken...")
        if error != nil {
            print(error)
            return
        }

        guard let imageData = photo.fileDataRepresentation()
        else { return }

        self.picData = imageData

    }

    func savePic() {

        guard let picData = self.picData,
              let image = UIImage.init(data: picData)
        else { return }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        self.isSaved = true
        print("saved successfully")
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {

        let view = UIView(frame: UIScreen.main.bounds)

        camera.preview = AVCaptureVideoPreviewLayer.init(session: camera.session)

        camera.preview.frame = view.bounds

        camera.preview.videoGravity = .resizeAspectFill

        view.layer.addSublayer(camera.preview)
        DispatchQueue.global(qos: .userInitiated).async {
            camera.session.startRunning()
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview.frame = view.bounds
    }
}

#Preview {
    CameraScreen2()
}
