//
//  CameraScreen.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-12.
//

import SwiftUI
import AVFoundation

struct CameraScreen: View {

    @StateObject var camera = CameraModel()
    var body: some View {

        ZStack {

            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)

            VStack {

                if camera.isTaken {
                    HStack {
                        Spacer()

                        Button {

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

                        } label: {
                            Text("Save")
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
                            camera.isTaken.toggle()

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

class CameraModel: ObservableObject {

    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
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
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)!

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
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {

        let view = UIView(frame: UIScreen.main.bounds)

        camera.preview = AVCaptureVideoPreviewLayer.init(session: camera.session)

        camera.preview.frame = view.bounds

        camera.preview.videoGravity = .resizeAspectFill

        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview.frame = view.bounds
    }
}

#Preview {
    CameraScreen()
}
