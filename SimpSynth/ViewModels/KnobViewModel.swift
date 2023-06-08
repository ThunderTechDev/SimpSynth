//
//  KnobViewModel.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 8/6/23.
//

import SwiftUI


class KnobViewModel: ObservableObject {
    // Variable para el título del knob
    let title: String
    

    // Variable para la rotación del knob
    @Published var rotation: Double = 0

    // Variable para mantener un registro del valor anterior del gesto
    var previousGestureValue: CGFloat = 0

    // Variable para mantener un registro del valor de rotación anterior
    var previousRotation: Double = 0

    // Referencia a tu modelo de AudioMIDI
    var audioMIDI: AudioMIDI

    // Inicializador
    init(title: String, audioMIDI: AudioMIDI) {
        self.title = title
        self.audioMIDI = audioMIDI
    }

    // Método para actualizar la rotación basado en un gesto
    func updateRotation(from gesture: DragGesture.Value) {
        
        
        
        // Calcula el cambio en la posición del gesto
        let delta = gesture.translation.height - previousGestureValue

        // Actualiza la rotación basándote en el cambio
        rotation = previousRotation - Double(delta)

        // Guarda el valor actual del gesto y la rotación para la próxima vez
        previousGestureValue = gesture.translation.height
        previousRotation = rotation
        print(rotation)
        // Actualiza el modelo de AudioMIDI según corresponda
        updateAudioMIDI()
    }

    // Método para actualizar el modelo de AudioMIDI
    func updateAudioMIDI() {
        // Aquí es donde actualizarías tu modelo de AudioMIDI basándote en la rotación
        // Por ejemplo:
        // audioMIDI.volume = rotation / 360
    }
    
    func resetGestureValue() {
           previousGestureValue = 0
           previousRotation = rotation
       }
    
}
