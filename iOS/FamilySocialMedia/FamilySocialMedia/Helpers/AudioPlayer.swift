//
//  AudioPlayer.swift
//  FamilySocialMedia
//
//  Created by Mohamed Alwakil on 2025-03-15.
//
import AVFoundation

enum Audio {
    case cameraShutter
}
@Observable
class AudioPlayer {

    var soundEffect: AVAudioPlayer?

    private func play(name: String) {

        let path = Bundle.main.path(forResource: name, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }

    func play(audio: Audio) {
        switch audio {
        case .cameraShutter:
            play(name: "camera-shutter-classic.mp3")

        }
    }

}
