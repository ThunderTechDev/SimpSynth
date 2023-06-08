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
    
    
    
    var body: some View {
        
    
        
        
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    KnobView(knobViewModel: KnobViewModel(title: "Volume", audioMIDI: audioMIDI))
                    KnobView(knobViewModel: KnobViewModel(title: "Reverb", audioMIDI: audioMIDI))
                    KnobView(knobViewModel: KnobViewModel(title: "Delay", audioMIDI: audioMIDI))
                    KnobView(knobViewModel: KnobViewModel(title: "Release", audioMIDI: audioMIDI))
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
                    
                    .onAppear {
                            do {
                                try audioMIDI.audioEngine.start()
                            } catch {
                                print("Error starting audio engine: \(error)")
                            }
                        }
                
                    
                    
                    .environmentObject(audioMIDI)
                    
               
                
            }
        }
        
       
        
       
    }

    
       
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
