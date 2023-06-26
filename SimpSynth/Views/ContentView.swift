//
//  ContentView.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 31/5/23.
//

import SwiftUI
import AudioKit
import Keyboard

struct ContentView: View {
    @StateObject var audioMIDI = AudioMIDI()

    // Crea una @StateObject para cada KnobViewModel
    @StateObject var volumeKnobViewModel: KnobViewModel
    @StateObject var reverbKnobViewModel: KnobViewModel
    @StateObject var delayKnobViewModel: KnobViewModel
    @StateObject var releaseKnobViewModel: KnobViewModel

    init() {
        let audioMIDI = AudioMIDI()
        _audioMIDI = StateObject(wrappedValue: audioMIDI)
        _volumeKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Volume", initialValue: 0, audioMIDI: audioMIDI, control: .volume, previousRotation: 0))
        _reverbKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Reverb", initialValue: 0.0, audioMIDI: audioMIDI, control: .reverb, previousRotation: 0))
        _delayKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Delay", initialValue: 0.0, audioMIDI: audioMIDI, control: .delay, previousRotation: 0))
        _releaseKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Release", initialValue: 0.0, audioMIDI: audioMIDI, control: .release, previousRotation: 0))
    }

    var body: some View {
        // Contenido de tu vista
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    KnobView(knobViewModel: volumeKnobViewModel)
                    KnobView(knobViewModel: reverbKnobViewModel)
                    KnobView(knobViewModel: delayKnobViewModel)
                    KnobView(knobViewModel: releaseKnobViewModel)
                }
                Keyboard(layout: .piano(pitchRange: Pitch(60) ... Pitch(72)),
                                      noteOn: audioMIDI.noteOn, noteOff: audioMIDI.noteOff) { pitch, isActivated in
                                 KeyboardKey(pitch: pitch,
                                             isActivated: isActivated,
                                             text: "",
                                             pressedColor: Color(.purple),
                                             alignment: .center)
                                 .gesture(DragGesture(minimumDistance: 0)
                                            .onChanged { _ in
                                                self.audioMIDI.noteOn(pitch: pitch, point: .zero)
                                            }
                                            .onEnded { _ in
                                                self.audioMIDI.noteOff(pitch: pitch)
                                            })
                             }
                          
                             
                                 
                                      
                                 .background(.black)
                                 
            }
        }
       
        .environmentObject(audioMIDI)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
