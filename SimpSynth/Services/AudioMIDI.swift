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
    let audioEngine = AVAudioEngine()
    let midiSampler = AVAudioUnitSampler()

    
    
    
    init() {
        setupAudioEngine()
        midiSampler.volume = 0.5
    }
    
    private func setupAudioEngine() {
        audioEngine.attach(midiSampler)
        
        audioEngine.connect(midiSampler, to: audioEngine.mainMixerNode, format: nil)
        
        do {
            try audioEngine.start()
            if let url = Bundle.main.url(forResource: "8bits", withExtension: "SF2", subdirectory: "Resources") {
                try midiSampler.loadPreset(at: url)
            }
        } catch {
            print("Error al iniciar AVAudioEngine: \(error)")
        }
    }
    
    func noteOn(pitch: Pitch, point: CGPoint) {
        let midiNoteNumber = UInt8(pitch.midiNoteNumber)
        midiSampler.startNote(midiNoteNumber, withVelocity: 127, onChannel: 0)

    }
    
    func noteOff(pitch: Pitch) {
        let midiNoteNumber = UInt8(pitch.midiNoteNumber)
        midiSampler.stopNote(midiNoteNumber, onChannel: 0)

    }
}
