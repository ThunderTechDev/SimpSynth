//
//  KnobView.swift
//  SimpSynth
//
//  Created by Sergio Gonzalez Cristobal on 8/6/23.
//

import SwiftUI

struct KnobView: View {
    @ObservedObject var knobViewModel: KnobViewModel

    var body: some View {
        VStack {
            HStack {
                Text(knobViewModel.title)
                    .font(.body)
                    .foregroundColor(.purple)

                Text(String(knobViewModel.rotationValue))
                    .font(.body)
                    .foregroundColor(.white)
            }

            Image("KnobsNEW")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.degrees(knobViewModel.rotation))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            knobViewModel.updateRotation(from: gesture)
                           
                        }
                        .onEnded { _ in
                            knobViewModel.resetGestureValue()
                           
                        }
                )
        }
        .padding(.top)
    }
}



