//
//  WiningView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 28/08/2023.
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct WiningView: View {
    @Binding var userName: String
    @Binding var highestScore: Int
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var leaderboardRefresh: LeaderboardRefresh
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var audioPlayer: AVAudioPlayer?
    
    
    var body: some View {
        VStack{
            HStack{
                Text(gameLanguage == "english" ? "🥳You win this mode!!!" : "🥳Bạn đã chiến thắng!!")
                    .font(.title)
                    .fontWidth(.expanded)
                    .padding()
                Image("win")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            Text(gameLanguage == "english" ? "Your name: \(userName)" : "Tên người chơi: \(userName)")
                .fontWeight(.light)
                .padding()
            
            Button {
                ScoreManager.shared.addScore(userName: userName, score: highestScore)//Button to save data when clicked
                leaderboardRefresh.refresh = true
                dismiss()
                
            } label: {
                
                PrimaryButton(text: gameLanguage == "english" ? "Get your score😙: \(highestScore)" : "Nhận điểm của bạn 😙 : \(highestScore)")
                    .fontWeight(.heavy)
            }
        }.onAppear{
            playSound(sound: "wining", type: "mp3")
        }
    }
}
@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct WiningView_Previews: PreviewProvider {
    static var previews: some View {
        WiningView(userName: .constant(""), highestScore: .constant(0), gameLanguage: "english")
    }
}
