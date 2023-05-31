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
            
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Keyboard(layout: .piano (pitchRange: Pitch(60) ... Pitch(70))) { pitch, isActivated in
                    KeyboardKey(pitch: pitch,
                                isActivated: isActivated,
                                text: "",
                                pressedColor: Color(.purple),
                                alignment: .center)
                }
                    
                    .padding(.all)
                    .background(.black)
                    
                    .onAppear {
                        audioMIDI.activateMIDI()
                        }
                    .onDisappear {
                        audioMIDI.deactivateMIDI()
                    }
                    
                    .environmentObject(audioMIDI)
                    
                    .padding()
                
            }
        }
        
       
        
       
    }
    
       
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
