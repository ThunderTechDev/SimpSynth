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
    let dryWetMixer: DryWetMixer
    let mixer: Mixer
    

    
    
    
    init() {
           
            sampler = AudioKit.MIDISampler()
            sampler.volume = 0
        
        
            delay = Delay(sampler)
            delay.feedback = 0.95
            delay.time = 0.40

            delay.dryWetMix = 0

            
            reverb = Reverb(sampler)
            reverb.dryWetMix = 0
            reverb.loadFactoryPreset(.largeHall)
            
            
            dryWetMixer = DryWetMixer(sampler, delay)
            mixer = Mixer(dryWetMixer, reverb)
            engine.output = mixer
            
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
