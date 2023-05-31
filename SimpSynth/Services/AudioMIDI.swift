//
//  AudioMIDI.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 31/5/23.
//

import AVFoundation
import AudioKit
import Keyboard

class AudioMIDI: ObservableObject {
    let midi = MIDI()
    
    func activateMIDI () {
        midi.openOutput()
    }
    
    func deactivateMIDI () {
        midi.closeInput()
    }
    
    //Funciones provisionales para llamar desde el teclado
    
    func noteOn(pitch: Pitch, point: CGPoint) {
        print("note on \(pitch)")
    }

    func noteOff(pitch: Pitch) {
        print("note off \(pitch)")
    }
    
}
