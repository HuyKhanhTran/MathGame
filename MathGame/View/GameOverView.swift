//
//  GameOverView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//
/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Huy Khanh
  ID: Your student id: s3804620
  Created  date: 18/08/2023
  Last modified: 05/09/2023
  Acknowledgement: SwiftUI, AVFoundation.
*/
import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct GameOverView: View {
    @Binding var userName: String
    @Binding var highestScore: Int
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var leaderboardRefresh: LeaderboardRefresh
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var audioPlayer: AVAudioPlayer?
  
    var body: some View {
       
            VStack {
                HStack{
                    Text(gameLanguage == "english" ? "Game Over!!!" : "Trò chơi kết thúc!!!")
                        .font(.title)
                        .fontWidth(.expanded)
                        .padding()
                    Image("tomb")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        
                }
                Text(gameLanguage == "english" ? "Your name: \(userName)" : "Tên người chơi: \(userName)")
                    .fontWeight(.light)
                    .padding()
                Button {
                    ScoreManager.shared.addScore(userName: userName, score: highestScore)
                    leaderboardRefresh.refresh = true
                    dismiss()
                    
                } label: {
                    
                    PrimaryButton(text: gameLanguage == "english" ? "Get your score😧: \(highestScore)" : "Nhận điểm của bạn 😧 : \(highestScore)")
                        .fontWeight(.heavy)
                }
                
                
            
        }.onAppear{
                playSound(sound: "gameover-86548", type: "mp3")
            }
            .padding()
            .background(isDarkMode ? .black : .white)


    }
    
}

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(userName: .constant(""), highestScore: .constant(0), gameLanguage: "english")
                
    }
}

