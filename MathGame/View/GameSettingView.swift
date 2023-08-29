////
////  GameSettingView.swift
////  MathGame
////
////  Created by Khanh, Tran Huy on 18/08/2023.
////
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
struct GameSettingView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Binding var gameMode: String
    @AppStorage("easyIsClicked") var easyIsClicked: Bool = true
    @AppStorage("mediumIsClicked") var mediumIsClicked: Bool = false
    @AppStorage("hardIsClicked") var hardIsClicked: Bool = false
    @AppStorage("englishIsClicked") var englishIsClicked: Bool = true
    @AppStorage("vietnameseIsClicked") var vietnameseIsClicked: Bool = false
    @State private var darkmode = false
    @Binding var gameLanguage: String
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var audioPlayer: AVAudioPlayer?
    func loadDescription() -> String {
        var description = ""
        
        if easyIsClicked == true {
            if englishIsClicked == true {
                description = "Perform calculations with natural numbers less than 100."
            } else {
                description = "Thực hiện các phép tính với số tự nhiên bé hơn 100."
            }
        } else if mediumIsClicked == true {
            if englishIsClicked == true {
                description = "Perform calculations with natural numbers between 200 and 400 with random calculation."
            } else {
                description = "Thực hiện các phép tính với số tự nhiên trong khoảng từ 200 đến 400 với phép tính ngẫu nhiên."
            }
        } else {
            if englishIsClicked == true {
                description = "Perform calculations with natural numbers between 400 and 1000 with random calculation😈."
            } else {
                description = "Thực hiện các phép tính với số tự nhiên trong khoảng từ 400 đến 1000 với phép tính ngẫu nhiên😈."
            }
        }
        
        return description
    }
    var body: some View {
        ZStack{
            Image("gameover1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(spacing: 25){
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 150)
                    Button(action: {
                        isDarkMode.toggle() // Toggle dark mode setting
                    }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(.purple)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 3, height: 50)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(isDarkMode ? Color("AccentColor") : .gray).opacity(0.5))
                        
                    }
                    Divider()
                    Text(englishIsClicked ? "Language" : "Ngôn ngữ")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    HStack{
                        Button{
                            gameLanguage = "english"
                            englishIsClicked = true
                            vietnameseIsClicked = false
                        } label: {
                            Text(englishIsClicked ? "English" : "Tiếng Anh")
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 70)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(englishIsClicked ? Color("AccentColor") : .gray).opacity(0.5))
                        }
                        Button{
                            gameLanguage = "vietnamese"
                            englishIsClicked = false
                            vietnameseIsClicked = true
                        } label: {
                            Text(englishIsClicked ? "Vietnamese" : "Tiếng Việt")
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 70)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(vietnameseIsClicked ? Color("AccentColor") : .gray).opacity(0.5))
                        }
                    }
                    Divider()
                    Text(englishIsClicked ? "Difficulty" : "Độ khó")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    HStack{
                        Button {
                            gameMode = "easy"
                            easyIsClicked = true
                            mediumIsClicked = false
                            hardIsClicked = false
                        } label: {
                            Text(englishIsClicked ? "Easy" : "Dễ")
                                .frame(width: (UIScreen.main.bounds.width - 70) / 3, height: 70)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(easyIsClicked ? Color("AccentColor") : .gray).opacity(0.5))
                            
                        }
                        
                        
                        
                        Button {
                            gameMode = "medium"
                            mediumIsClicked = true
                            easyIsClicked = false
                            hardIsClicked = false
                        } label: {
                            Text(englishIsClicked ? "Medium" : "Trung bình")
                                .frame(width: (UIScreen.main.bounds.width - 70) / 3, height: 70)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(mediumIsClicked ? Color("AccentColor") : .gray).opacity(0.5))
                        }
                        
                        Button {
                            gameMode = "hard"
                            hardIsClicked = true
                            easyIsClicked = false
                            mediumIsClicked = false
                        } label: {
                            Text(englishIsClicked ? "Hard" : "Khó")
                                .frame(width: (UIScreen.main.bounds.width - 70) / 3, height: 70)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundColor(hardIsClicked ? Color("AccentColor") : .gray).opacity(0.5))
                        }
                        
                    }
                    
                    
                    Text(englishIsClicked ? "Description" : "Mô tả")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("\(loadDescription())")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: UIScreen.main.bounds.width - 20, height: 100)
                        .background(RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.gray).opacity(0.5))
                        
                    
                }
                .navigationTitle(englishIsClicked ? "Game Setting" : "Cài đặt")
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
                    }
                    }  .onAppear{
                        if let soundURL = Bundle.main.url(forResource: "interface-124464", withExtension: "mp3") {
                            do {
                                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                                audioPlayer?.play()
                            } catch {
                                print("Error loading or playing sound effect:", error.localizedDescription)
                            }
                        }
                    }
                
            }.padding(50)
            .background(isDarkMode ? .black : .white)
            .frame(width: 300, height: 400)
                
              
        }.opacity(0.9)
    }


}
   

@available(iOS 15.0, *)
struct GameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingView(gameMode: .constant("easy"), gameLanguage: .constant("english"))
    }
}
