//
//  AnswerButton.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI
import AVFoundation

@available(iOS 15.0, *)
struct AnswerButton: View {
    var number: Int
    var isCorrect: Bool
    var animation: Animation = .easeIn(duration: 0.3)
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            Text("\(number)")
                .frame(width: 150, height: 100)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.white)
                .background(isCorrect ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                .cornerRadius(10)
                .padding()
        }
        .onAppear {
            withAnimation(animation) {
                playSound(sound: "sound-effect-twinklesparkle-115095", type: "mp3")
            }
        }
    }
}

@available(iOS 15.0, *)
struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(number: 1000, isCorrect: true, animation: .easeIn(duration: 0.6))
    }
}
