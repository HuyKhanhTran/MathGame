//
//  RegisterView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI
import AVFoundation

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct RegisterView: View {
   
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var userName: String = ""
    @State var gameMode: String
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        
        ZStack{
                Image("gameover1")
                
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100)

                    Text(gameLanguage == "english" ? "User Registration" : "Đăng ký người chơi")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    TextField(gameLanguage == "english" ? "User name" : "Tên người chơi", text: $userName)
                        .frame(width: 200, height: 40)
                        .padding(.leading, 4.0)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.black, lineWidth: 2)
                                .frame(width: 250, height: 40))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    NavigationLink(destination : destinationView){
                        PrimaryButton(text:(gameLanguage == "english" ? "Start" : "Bắt đầu"))
                            .fontWeight(.heavy)
                    }
                    .disabled(userName.isEmpty)
                   
                    
                }.navigationTitle(gameLanguage == "english" ? "Register Player" : "Đăng nhập người chơi")
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
                    playSound(sound: "game-start-6104", type: "mp3")
                     
                }
                .padding()
                .background(Image("background1"))
                .cornerRadius(10)
                .shadow(radius: 5)
        
                
            }
        }
    private var destinationView: some View {
           Group {
               if gameMode == "easy" {
                   GameView(userName: $userName, gameLanguage: gameLanguage)
                } else if gameMode == "medium"{
                   Game1View(userName: $userName, gameLanguage: gameLanguage)
               } else if gameMode == "hard"{
                   Game2View(userName: $userName, gameLanguage: gameLanguage)
               }
               else {
                   Text("None")
               }
           }
       }
    
}

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(gameMode: "easy", gameLanguage: "english")
              
    }
}

