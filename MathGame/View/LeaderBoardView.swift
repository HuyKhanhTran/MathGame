//
//  LeaderBoardView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)


struct LeaderBoardView: View {
    @EnvironmentObject private var leaderboardRefresh: LeaderboardRefresh// Environment object for refreshing leaderboard
    let scores = ScoreManager.shared.getLeaderboard()// Fetch scores from the ScoreManager
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showAchievementPopup = false
    @State private var selectedUserAchievementMessage = ""
    @State private var selectedUsername = ""
    @State private var selectedUserScore = 0

    @AppStorage("isDarkMode") private var isDarkMode = false

    func getAchievementMessage(score: Int) -> String {// Function to get achievement message based on score
        if gameLanguage == "english" {
            if score <= 10 && score > 0 {
                return "gets new achievement in easy mode"
            } else if score <= 15 && score > 10 {
                return "gets new achievement in medium mode"
            } else if score <= 20 && score > 15 {
                return "gets new achievement in hard mode"
            } else if score == 0 {
                return "No achievement"
            } else {
                return ""
            }
        } else {
            if score <= 10 && score > 0 {
                return "nhận được thành tích mới trong chế độ dễ"
            } else if score <= 15 && score > 10 {
                return "nhận được thành tích mới trong chế độ trung bình"
            } else if score <= 20 && score > 15 {
                return "nhận được thành tích mới trong chế độ khó"
            } else if score == 0 {
                return "không có thành tích"
            } else {
                return ""
            }
        }
    }

    func getRankColor(_ index: Int) -> Color {// Implementation for color based on index
        switch index {
        case 0:
            return .yellow
        case 1:
            return Color(red: 192/255, green: 192/255, blue: 192/255)
        case 2:
            return Color(red: 0.8, green: 0.5, blue: 0.2)
        default:
            return .primary
        }
    }

    
    var body: some View {
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 100)
                VStack{
                    List(scores.indices, id: \.self) { index in// Implementation for displaying each leaderboard entry
                        let achievementMessage = getAchievementMessage(score: scores[index].score)
                        HStack {
                            Text("\(index + 1).")
                                .foregroundColor(Color("AccentColor"))
                                .font(.headline)
                            Text(scores[index].userName)
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("AccentColor"))
                                .onTapGesture {
                                    selectedUsername = scores[index].userName
                                    selectedUserScore = scores[index].score
                                    selectedUserAchievementMessage = achievementMessage
                                    showAchievementPopup = true
                                }
                            Spacer()
                            
                            Text(gameLanguage == "english" ? "Score: \(scores[index].score)" : "Điểm: \(scores[index].score)")
                                .font(.subheadline)
                                .foregroundColor(isDarkMode ? .black : .white)
                                .onTapGesture {
                                    selectedUsername = scores[index].userName
                                    selectedUserScore = scores[index].score
                                    selectedUserAchievementMessage = achievementMessage
                                    showAchievementPopup = true
                                }
                        }.listRowBackground(getRankColor(index))

                    }
                    .sheet(isPresented: $showAchievementPopup, content: { // Achievement popup sheet
                        ZStack{
                            Image("gameover1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.9)
                            VStack {
                                Text(gameLanguage == "english" ? "♕♕♕ Achievement ♕♕♕" : "♕♕♕ Thành tựu ♕♕♕")
                                    .font(Font.custom("Arial", size: 24))
                                    .foregroundColor(Color("AccentColor"))
                                    .padding(.top, 20)
                                
                                Text("\(selectedUsername) \(selectedUserAchievementMessage)")
                                    .font(Font.system(size: 15))
                                    .foregroundColor(isDarkMode ? .black : .white)
                                    .padding()
                                HStack{
                                    Text(gameLanguage == "english" ? "The correct answer: \(selectedUserScore)" : "Câu trả lời đúng: \(selectedUserScore)")
                                        .font(.headline)
                                        .foregroundColor(isDarkMode ? .black : .white)
                                        .padding()
                                    Image("cup")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                }
                                Button(gameLanguage == "english" ? "Close" : "Đóng lại") {
                                    showAchievementPopup = false
                                }.offset(x: 150)
                                    .padding()
                            }.frame(width: 400, height: 300)
                            .background(isDarkMode ? .white : .black)
                        }
                    })



                    .padding(.vertical, 10)
                }
                .navigationTitle(gameLanguage == "english" ? "Leader board" : "Bảng điểm")
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
                        playSound(sound: "chill1", type: "mp3")// Play sound on appear
                    }
            }
            .opacity(0.9)
            .background(Image("gameover1")
                .resizable()
                .aspectRatio(contentMode: .fill))
        
    }
    
}


@available(iOS 15.0, *)
struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(gameLanguage: "english")
    }
}
