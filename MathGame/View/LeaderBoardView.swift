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
    var body: some View {
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 100)
                List(scores.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1).")
                            .foregroundColor(Color.blue)
                            .font(.headline)
                        Text(scores[index].userName)
                            .font(.title3)
                            .foregroundColor(Color.primary)
                        Spacer()
                        
                        Text("Score: \(scores[index].score)")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        
                        
                    }
                    .padding(.vertical, 8)
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
                        playSound(sound: "intro-koto-japanese-style-66781", type: "mp3")
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
