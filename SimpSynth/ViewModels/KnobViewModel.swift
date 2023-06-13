//
//  KnobViewModel.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 8/6/23.
//

import SwiftUI

enum AudioControl {
    case volume
    case reverb
    case delay
    case release
}


class KnobViewModel: ObservableObject {
    let title: String
    @Published var rotation: Double = 0
    var previousGestureValue: CGFloat = 0
    var previousRotation: Double = 0
    var audioMIDI: AudioMIDI
    var control: AudioControl

       init(title: String, initialValue: Double, audioMIDI: AudioMIDI, control: AudioControl) {
           self.title = title
           self.rotation = initialValue
           self.audioMIDI = audioMIDI
           self.control = control
       }

    func updateRotation(from gesture: DragGesture.Value) {
        let delta = gesture.translation.height - previousGestureValue
        rotation = previousRotation - Double(delta)
        rotation = max(0, min(rotation, 360))
        previousGestureValue = gesture.translation.height
        previousRotation = rotation
        updateAudioMIDI()
    }

    func updateAudioMIDI() {
            // Actualiza el parámetro de audio apropiado en tu modelo de AudioMIDI basándote en la rotación
            switch control {
            case .volume:
                let volume = Double(rotationValue) / 100
                audioMIDI.midiSampler.volume = Float(volume)
                print("actualizado el volumen a \(audioMIDI.midiSampler.volume)")
            case .reverb:
                return
            case .delay:
                return
            case .release:
                return
            }
        }

    func resetGestureValue() {
        previousGestureValue = 0
        previousRotation = rotation
    }

    var rotationValue: Int {
        return Int(rotation / 360 * 99)
    }
}
