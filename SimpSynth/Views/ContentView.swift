//
//  ContentView.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 31/5/23.
//

import SwiftUI
import AudioKit
import Keyboard
import AudioKitUI

struct ContentView: View {
    @StateObject var audioMIDI = AudioMIDI()
    @StateObject var volumeKnobViewModel: KnobViewModel
    @StateObject var reverbKnobViewModel: KnobViewModel
    @StateObject var delayKnobViewModel: KnobViewModel
    var waveView: NodeOutputView
    

    init() {
        let audioMIDI = AudioMIDI()
        _audioMIDI = StateObject(wrappedValue: audioMIDI)
        _volumeKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Volume", initialValue: 100, audioMIDI: audioMIDI, control: .volume, previousRotation: 100))
        _reverbKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Reverb", initialValue: 0.0, audioMIDI: audioMIDI, control: .reverb, previousRotation: 0))
        _delayKnobViewModel = StateObject(wrappedValue: KnobViewModel(title: "Delay", initialValue: 0.0, audioMIDI: audioMIDI, control: .delay, previousRotation: 0))
        waveView = NodeOutputView(audioMIDI.engine.mainMixerNode!, color: Color(red: 154/255, green: 9/255, blue: 206/255), backgroundColor: .black, bufferSize: 1024)
       
    }

    var body: some View {
       
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    KnobView(knobViewModel: volumeKnobViewModel)
                        .padding(.horizontal, 1)
                    KnobView(knobViewModel: reverbKnobViewModel)
                        .padding(.horizontal, 1)
                    KnobView(knobViewModel: delayKnobViewModel)
                        .padding(.horizontal, 1)
                    ZStack {
                            RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 154/255, green: 9/255, blue: 206/255), lineWidth: 12)
                            waveView
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }.padding(.horizontal, 10)
                     .padding(.vertical, 6)
                        
                                            
                    
                } .padding()

                Keyboard(layout: .piano(pitchRange: Pitch(60) ... Pitch(72)),
                                      noteOn: audioMIDI.noteOn, noteOff: audioMIDI.noteOff) { pitch, isActivated in
                                 KeyboardKey(pitch: pitch,
                                             isActivated: isActivated,
                                             text: "",
                                             pressedColor: Color(red: 154/255, green: 9/255, blue: 206/255),
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
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
