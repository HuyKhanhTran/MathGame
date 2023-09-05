//
//  HowToPlayView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 20/08/2023.
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
struct HowToPlayView: View {
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 100)
                Form {
                    Section(header: Text(gameLanguage == "english" ? "How To Play" : "Cách chơi trò chơi") .font(Font.custom("Arial", size: 20)) . bold()) {
                        Text(gameLanguage == "english" ? "⚀ Choose the game mode to play." : "Chọn chế độ chơi.")
                            .foregroundColor(Color("AccentColor"))
                        Image("howtoplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(gameLanguage == "english" ? "⚁ Regiser player's name." : "Đăng nhập tên người chơi.")
                            .foregroundColor(Color("AccentColor"))
                        Image("howtoplay1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(gameLanguage == "english" ? "⚂ Doing correctly answer the math problems given by the application." : "Chọn đúng câu trời toán học mà ứng dụng đưa ra.")
                            .foregroundColor(Color("AccentColor"))
                        Image("howtoplay2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text(gameLanguage == "english" ? "⚃ Trying to get the highest score." : "Cố gắng đạt diểm cao nhất")
                            .foregroundColor(Color("AccentColor"))
                        Image("howtoplay3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Section(header: Text(gameLanguage == "english" ? "Application Information" : "Thông tin ứng dụng") .font(Font.custom("Arial", size: 20)) . bold()) {
                        HStack {
                            Text(gameLanguage == "english" ? "★ App Name" : "Tên ứng dụng")
                            Spacer()
                            Text("Math game")
                        }.foregroundColor(Color("AccentColor"))
                        HStack {
                            Text("★ Course")
                            Spacer()
                            Text("COSC2659")
                        }.foregroundColor(Color("AccentColor"))
                        HStack {
                            Text(gameLanguage == "english" ? "★ Year Published" : "Năm công bố")
                            Spacer()
                            Text("2023")
                        }.foregroundColor(Color("AccentColor"))
                        HStack {
                            Text(gameLanguage == "english" ? "★ Location" : "Địa điểm")
                            Spacer()
                            Text("Saigon South Campus")
                        }.foregroundColor(Color("AccentColor"))
                    }
                }
            
        }.opacity(0.9)
            .background(Image("gameover1")
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
            playSound(sound: "chill1", type: "mp3")
        }
        
    }
}

@available(iOS 15.0, *)
struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView(gameLanguage: "english")
    }
}
