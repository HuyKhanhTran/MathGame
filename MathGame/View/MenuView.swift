//
//  MenuView.swift
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
  Last modified: dd/mm/yyyy
  Acknowledgement: SwiftUI, AVFoundation.
*/


import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct MenuView: View {
    
    @StateObject private var leaderboardRefresh = LeaderboardRefresh()
    @Binding var userName: String
   
    @State private var selectedGameMode = 100
    @State private var isGameSettingPresented = false
    @State private var isGameViewPresented = false
    @AppStorage("gameMode") var gameMode: String = "easy"
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("gameLanguage") var gameLanguage: String = "english"
    let darkBackground = Color(red: 0.189, green: 0.187, blue: 0.256)
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        
        NavigationView{
            ZStack{
                if isDarkMode {
                    darkBackground.edgesIgnoringSafeArea(.all)
                } else {
                    Color.white.edgesIgnoringSafeArea(.all)
                }
                ZStack{
                    //Color(.black).edgesIgnoringSafeArea(.all)
                    Image("gameover1")
                    
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 1)
                    VStack(spacing: 35){
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 100)
                        
                        NavigationLink(destination: RegisterView(gameMode: gameMode, gameLanguage: gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "Let's play!😋" : "Cùng chơi nào!😋"))
                                .fontWeight(.heavy)
                            
                        }
                        NavigationLink(destination: LeaderBoardView(gameLanguage: gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "Leader Board" : "Bảng điểm"))
                                .fontWeight(.heavy)
                        }
                        
                        NavigationLink(destination: GameSettingView(gameMode: $gameMode, gameLanguage: $gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "Game Setting" : "Cài đặt trò chơi"))
                                .fontWeight(.heavy)
                        }
                        NavigationLink(destination: HowToPlayView(gameLanguage: gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "How to play" : "Hướng dẫn chơi"))
                                .fontWeight(.heavy)
                        }
                    }.padding()
                    
                }.onAppear {
                    playSound(sound: "chill", type: "mp3")
                        
                }
                
            }
        }.navigationViewStyle(.stack)
        .environmentObject(leaderboardRefresh)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        
    }
}
class LeaderboardRefresh: ObservableObject {
    @Published var refresh: Bool = false
}
@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
            MenuView(userName: .constant(""))
               
    }
}

