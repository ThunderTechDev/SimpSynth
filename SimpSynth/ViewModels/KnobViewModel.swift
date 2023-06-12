//
//  KnobViewModel.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 8/6/23.
//

import SwiftUI

class KnobViewModel: ObservableObject {
    let title: String
    @Published var rotation: Double = 0
    var previousGestureValue: CGFloat = 0
    var previousRotation: Double = 0
    var audioMIDI: AudioMIDI

    init(title: String, initialValue: Double, audioMIDI: AudioMIDI) {
        self.title = title
        self.rotation = initialValue
        self.audioMIDI = audioMIDI
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
        // Aquí es donde actualizarías tu modelo de AudioMIDI basándote en la rotación
    }

    func resetGestureValue() {
        previousGestureValue = 0
        previousRotation = rotation
    }

    var rotationValue: Int {
        return Int(rotation / 360 * 99)
    }
}
