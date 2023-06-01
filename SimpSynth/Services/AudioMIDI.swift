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
    private let midiSampler = AVAudioUnitSampler()
    
    init() {
        setupAudioEngine()
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
        let midiNoteNumber = 20 //número provisional
        midiSampler.startNote(UInt8(midiNoteNumber), withVelocity: 127, onChannel: 0)
        print("note on \(midiNoteNumber)")
    }

    func noteOff(pitch: Pitch) {
        let midiNoteNumber = 20 //número provisional
        midiSampler.stopNote(UInt8(midiNoteNumber), onChannel: 0)
        print("note off \(midiNoteNumber)")
    }
}
