//
//  MenuView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
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
                    Image("gameover")
                    
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
                            
                        }
                        NavigationLink(destination: LeaderBoardView(gameLanguage: gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "Leader Board" : "Bảng điểm"))
                        }
                        
                        NavigationLink(destination: GameSettingView(gameMode: $gameMode, gameLanguage: $gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "Game Setting" : "Cài đặt trò chơi"))
                        }
                        NavigationLink(destination: HowToPlayView(gameLanguage: gameLanguage)){
                            PrimaryButton(text: (gameLanguage == "english" ? "How to play" : "Hướng dẫn chơi"))
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
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
            MenuView(userName: .constant(""))
               
    }
}

