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
    @EnvironmentObject private var leaderboardRefresh: LeaderboardRefresh
    let scores = ScoreManager.shared.getLeaderboard()
    @State var gameLanguage: String
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showAchievementPopup = false
    @State private var selectedUserAchievementMessage = ""
    @State private var selectedUsername = ""
    @State private var selectedUserScore = 0

    @AppStorage("isDarkMode") private var isDarkMode = false

    func getAchievementMessage(score: Int) -> String {
        if score <= 10 && score > 0 {
            return "gets new achievement in easy mode"
        } else if score < 15 && score > 10 {
            return "gets new achievement in medium mode"
        } else if score < 20 && score > 15 {
            return "gets new achievement in hard mode"
        } else if score == 0 {
            return "No achievement"
        }
        else {
            return ""
        }
    }
    func getRankColor(_ index: Int) -> Color {
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
                    List(scores.indices, id: \.self) { index in
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
                            
                            Text("Score: \(scores[index].score)")
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
                    .sheet(isPresented: $showAchievementPopup, content: {
                        VStack {
                            Text("♕♕♕Achievement♕♕♕")
                                .font(.title)
                                .foregroundColor(Color("AccentColor"))
                                .padding(.top, 20)
                            
                            Text("\(selectedUsername) \(selectedUserAchievementMessage)")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                            Text("The correct answer: \(selectedUserScore)")
                                .font(.headline)
                                .foregroundColor(.green)
                                .padding()
                            Button(gameLanguage == "english" ? "Close" : "Đóng lại") {
                                showAchievementPopup = false
                            }
                            .padding()
                        }
                        .frame(width: 400, height: 250)
                        .background(isDarkMode ? .white : .gray)
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
                        playSound(sound: "chill1", type: "mp3")
                    }
            }
            .opacity(0.9)
            .background(Image("gameover")
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
