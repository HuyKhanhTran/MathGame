//
//  HowToPlayView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 20/08/2023.
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
struct HowToPlayView: View {
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        VStack{
                Image("logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                Form {
                    Section(header: Text("How To Play")) {
                        Text("⚀ Choose the game mode to play.")
                        Image("howtoplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("⚁ Regiser player's name.")
                        Image("howtoplay1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("⚂ Doing correctly answer the math problems given by the application.")
                        Image("howtoplay2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("⚃ Trying to get the highest score.")
                        Image("howtoplay3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Section(header: Text("Application Information")) {
                        HStack {
                            Text("★ App Name")
                            Spacer()
                            Text("Math game")
                        }
                        HStack {
                            Text("★ Course")
                            Spacer()
                            Text("COSC2659")
                        }
                        HStack {
                            Text("★ Year Published")
                            Spacer()
                            Text("2023")
                        }
                        HStack {
                            Text("★ Location")
                            Spacer()
                            Text("Saigon South Campus")
                        }
                    }
                }
            
        }.opacity(0.9)
            .background(Image("gameover")
                .resizable()
                .aspectRatio(contentMode: .fill))
        .navigationTitle(gameLanguage == "english" ? "How to play" : "Hướng dẫn chơi")
        .navigationBarBackButtonHidden(true)
        .toolbar{ToolbarItem(placement: ToolbarItemPlacement .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "arrow.left")
                        Text(gameLanguage == "english" ? "Return" : "Quay lại ")
                    }
                }
            }}
        .onAppear{
            playSound(sound: "intro-koto-japanese-style-66781", type: "mp3")
        }
        
    }
}

@available(iOS 15.0, *)
struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView(gameLanguage: "english")
    }
}
