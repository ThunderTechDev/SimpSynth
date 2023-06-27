//
//  AudioMIDI.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 31/5/23.
//

import AVFoundation
import AudioKit
import AudioKitEX
import Keyboard


class AudioMIDI: ObservableObject {
    let engine = AudioEngine()
    var sampler: AudioKit.MIDISampler
    var reverb: Reverb
    var delay: Delay



    

    
    
    
    init() {
           
            sampler = AudioKit.MIDISampler()
            sampler.volume = 1
        
            
        
            delay = Delay(sampler)
            delay.feedback = 30.00
            delay.time = 0.5
            delay.dryWetMix = 0
        
            reverb = Reverb(delay)
            reverb.dryWetMix = 0
            reverb.loadFactoryPreset(.largeHall)
            
            
            
            engine.output = (reverb)
            engine.mainMixerNode?.volume = 0.88
            
            // Asegúrate de empezar el motor de AudioKit
            do {
                try engine.start()
                
                
            } catch {
                print("Error al iniciar el motor de AudioKit: \(error)")
            }
            
            
        
        }
    
    func noteOn(pitch: Pitch, point: CGPoint) {
        let midiNoteNumber = UInt8(pitch.midiNoteNumber)
        sampler.play(noteNumber: midiNoteNumber, velocity: 127, channel: 0)

    }
    
    func noteOff(pitch: Pitch) {
        let midiNoteNumber = UInt8(pitch.midiNoteNumber)
        sampler.stop(noteNumber: midiNoteNumber, channel: 0)

    }
}
