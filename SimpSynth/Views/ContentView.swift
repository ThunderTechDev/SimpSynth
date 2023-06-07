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
    @State private var rotationKnob1: Double = 0
    @State private var rotationKnob2: Double = 0
    @State private var rotationKnob3: Double = 0
    @State private var rotationKnob4: Double = 0
    
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                        knobView(title: "Volumen", rotation: $rotationKnob1)
                        knobView(title: "Release", rotation: $rotationKnob2)
                        knobView(title: "Reverb", rotation: $rotationKnob3)
                        knobView(title: "Delay", rotation: $rotationKnob4)
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

    func knobView(title: String, rotation: Binding<Double>) -> some View {
        VStack {
            Text(title)
                .font(.body)
                .foregroundColor(.white)

            Image("Knob")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(degrees: rotation.wrappedValue))
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                // Actualizar el valor de la rotación en función del movimiento del arrastre
                                rotation.wrappedValue = Double(gesture.translation.height)
                                print(Double(gesture.translation.height))
                                // Aquí también puedes actualizar el volumen en función de la rotación
                            })
        }
    }
    
       
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
