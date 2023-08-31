//
//  GameView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI
import Foundation

import AVFoundation
@available(iOS 15.0, *)
@available(iOS 16.0, *)

struct GameView: View {
    
    
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var operation: MathOperation = .addition
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var points = 100
    @State private var score = 0
    @Environment(\.dismiss) var dismiss
    @State private var currentHealth = 5
    @Binding var userName: String
    @State private var isGameOver: Bool = false
    @State private var highestScore = 0
    @State var gameLanguage: String
    @State private var divisionResult: Double = 0.0
    @State private var healthReduce = false
    @State private var answerCorrect: Bool = false
    @State private var answerInCorrect: Bool = false
    @State private var audioPlayerCorrect: AVAudioPlayer?
    @State private var audioPlayerIncorrect: AVAudioPlayer?
    @AppStorage("isDarkMode") private var isDarkMode = false
   
    
    func answerIsCorrect(answer: Int){
        print(currentHealth)
        if answer == correctAnswer {
            self.score += 1 // set the score +1 when have a correct answer
            answerCorrect = true
        } else {
            currentHealth -= 1 // set currentHealth - 1 when have a incorrect answer
            
            healthReduce = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    healthReduce = false
            }
            losingGame()
            answerInCorrect = true
            
        }
        winGame()
        
    }
    func losingGame(){
        if currentHealth == 0{ //set game over when currentHealth = 0
            saveHighScore(userName: userName, highestscore: highestScore)// make conditon for losing game
            
            UserDefaults.standard.removeObject(forKey: "savedGameState")
            isGameOver = true
            
        }
    }
    func winGame(){
        if score == 10{
            saveHighScore(userName: userName, highestscore: highestScore) // make conditon for win game
            
            UserDefaults.standard.removeObject(forKey: "savedGameState")
            isGameOver = true
        }
    }
    func saveHighScore(userName: String, highestscore: Int){ // function to save userName and score
        if score > highestScore {
            highestScore = score // make this codition to update the highest score
            ScoreManager.shared.updateHighestScore(userName: userName, newScore: highestscore)
        }
        
        
    }
  
    func generateAnswers() {

  
        
        firstNumber = Int.random(in: 0...(points / 2))
        secondNumber = Int.random(in: 1...(points / 2))

        if score < 5 { // set the game level higher when score < 5
                operation = [.addition, .subtraction].randomElement() ?? .addition
            } else {
                operation = MathOperation.random()
            }
        switch operation {
        case .addition:
            correctAnswer = firstNumber + secondNumber
        case .subtraction:
            correctAnswer = firstNumber - secondNumber
        case .multiplication:
            correctAnswer = firstNumber * secondNumber
        case .division:
            // Handle division result not being a whole number
            divisionResult = Double(firstNumber) / Double(secondNumber)
            correctAnswer = Int(divisionResult)
        }

        var answerList = [Int]()

        for _ in 0...2 {
            answerList.append(Int.random(in: -points...points)) // generate answer in negative and positive answer
        }

        answerList.append(correctAnswer) // Append the correct answer

        choiceArray = answerList.shuffled()
        winGame()
    }


    func saveGameState() {// func to save the state of game when playing
        let gameState = GameState(score: score, currentHealth: currentHealth)
        let data = try? JSONEncoder().encode(gameState)
        UserDefaults.standard.set(data, forKey: "savedGameState")
    }

    func loadSavedGameState() {// func to load the game stateed that saved to continue
        if let data = UserDefaults.standard.data(forKey: "savedGameState"),
           let gameState = try? JSONDecoder().decode(GameState.self, from: data) {
            score = gameState.score
            currentHealth = gameState.currentHealth
            isGameOver = false
            //generateAnswers()
        }
    }

    var body: some View {
        ZStack{
            Image("gameover")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack {
                
                
                if score == 10 { // set condition on View when user get eoungh score to win
                    WiningView(userName: $userName, highestScore: $highestScore, gameLanguage: gameLanguage)
                } else if isGameOver {//set condition on View when user get currentHealth = 0, they lose game
                    GameOverView(userName: $userName, highestScore: $highestScore, gameLanguage: gameLanguage)
                }
                else {
                    HStack{
                        Text("HP:")
                            .font(.headline)
                        HealthBarView(currentHealth: $currentHealth)
                            .opacity(healthReduce ? 0.7 : 1)
                            .offset(x: healthReduce ? 10 : 0)
                            .animation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2), value: healthReduce)
                        
                        Text(gameLanguage == "english" ? "Easy Mode" : "Chế độ dễ")
                            .font(.headline)
                        
                        
                        if UserDefaults.standard.data(forKey: "savedGameState") != nil {
                            Button {
                                loadSavedGameState()
                            } label: {
                                Image(systemName: "play.fill")
                            }
                        } else {
                            Button{
                                saveGameState()
                            } label: {
                                Image(systemName: "pause.fill")
                            }
                        }
                        
                    }
                    Text(gameLanguage == "english" ? "User name: \(userName)" : "Tên người chơi: \(userName)")
                        .font(.headline)
                    
                    PrimaryBorder(text: "\(firstNumber)\(operation.rawValue)\(secondNumber)")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.largeTitle)
                        .bold()
                        
                    
                    
                    HStack {
                        ForEach(0..<2) {index in
                            Button {
                                withAnimation{
                                    answerIsCorrect(answer: choiceArray[index])
                                    generateAnswers()
                                }
                            } label: {
                                AnswerButton(number: Int(Double(choiceArray[index])), isCorrect: true, animation: Animation.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2))
                                    
                            }
                            
                        }
                    }
                    
                    HStack {
                        ForEach(2..<4) {index in
                            Button {
                                withAnimation{
                                    answerIsCorrect(answer: choiceArray[index])
                                    generateAnswers()
                                }
                            } label: {
                                AnswerButton(number: Int(Double(choiceArray[index])), isCorrect: true, animation: Animation.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2))

                            }
                        }
                    }
                   PrimaryButton(text: gameLanguage == "english" ? "Score: \(score)" : "Điểm: \(score)")
                        .font(.headline)
                        .foregroundColor(.black)
                        
                    
                }
                
            }.navigationBarBackButtonHidden(true)
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
                .onAppear {
                    if let correctSoundURL = Bundle.main.url(forResource: "sound-effect-twinklesparkle-115095", withExtension: "mp3"),// set sound effect when choose correct answer
                       let incorrectSoundURL = Bundle.main.url(forResource: "negative_beeps-6008", withExtension: "mp3") { // set sound effect when choose incorrect answer
                        do {
                            audioPlayerCorrect = try AVAudioPlayer(contentsOf: correctSoundURL)
                            audioPlayerIncorrect = try AVAudioPlayer(contentsOf: incorrectSoundURL)
                        } catch {
                            print("Error loading or playing sound effect:", error.localizedDescription)
                        }
                    }
                    generateAnswers()
                }
                .onChange(of: healthReduce) { newValue in
                    if newValue {
                        audioPlayerIncorrect?.play() // Play the sound effect for health reduction
                    }
                }
                .onChange(of: answerCorrect) { newValue in
                    if newValue {
                        audioPlayerCorrect?.play() // Play the sound effect for correct answer
                        answerCorrect = false // Reset the state
                    }
                }
                .onChange(of: answerInCorrect) { newValue in
                    if newValue {
                        audioPlayerIncorrect?.play() // Play the sound effect for incorrect answer
                        answerInCorrect = false // Reset the state
                    }
                }
                .padding()
                .background(isDarkMode ? .black : .white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        
    }
}

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
            GameView(userName: .constant(""), gameLanguage: "english")
    }
}

    
