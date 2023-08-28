//
//  Game1View.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 21/08/2023.
//

import SwiftUI
import AVFoundation
@available(iOS 15.0, *)
struct Game1View: View {
    @Binding var userName: String
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var operation: MathOperation = .addition
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var points = 400{
        didSet {
            points = min(max(points, 200), 400)
        }
    }
    @State private var score = 0
    @State private var currentHealth = 5
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
    @Environment(\.dismiss) var dismiss
    func answerIsCorrect(answer: Int){
        print(currentHealth)
        if answer == correctAnswer {
            self.score += 1
            answerCorrect = true
        } else {
            currentHealth -= 1
            healthReduce = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    healthReduce = false
            }
            losingGame()
            answerInCorrect = true
            
        }
            
        
    }
    func losingGame(){
        if currentHealth == 0{
            saveHighScore(userName: userName, highestscore: highestScore)
            
            UserDefaults.standard.removeObject(forKey: "savedGameState")
            isGameOver = true
            
        }
    }
    
    func saveHighScore(userName: String, highestscore: Int){
        if score > highestScore {
            highestScore = score
            ScoreManager.shared.updateHighestScore(userName: userName, newScore: highestscore)
        }
        //ScoreManager.shared.addScore(userName: userName, score: score)
        
    }
  
    func generateAnswers() {

  
        
        firstNumber = Int.random(in: 0...(points / 2))
        secondNumber = Int.random(in: 1...(points / 2))

        if score < 3 {
                operation = [.addition, .subtraction].randomElement() ?? .addition
        } else if score < 6 {
            operation = [.addition, .subtraction, .multiplication].randomElement() ?? .addition
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
            answerList.append(Int.random(in: -points...points))
        }

        answerList.append(correctAnswer) // Append the correct answer

        choiceArray = answerList.shuffled()
    }


    func saveGameState() {
        let gameState = GameState(score: score, currentHealth: currentHealth)
        let data = try? JSONEncoder().encode(gameState)
        UserDefaults.standard.set(data, forKey: "savedGameState")
    }

    func loadSavedGameState() {
        if let data = UserDefaults.standard.data(forKey: "savedGameState"),
           let gameState = try? JSONDecoder().decode(GameState.self, from: data) {
            score = gameState.score
            currentHealth = gameState.currentHealth
            isGameOver = false
            generateAnswers()
        }
    }
    var body: some View {
        ZStack{
            Image("gameover")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            VStack {
                
                
                if isGameOver{
                    GameOverView(userName: $userName, highestScore: $highestScore, gameLanguage: gameLanguage)
                } else {
                    HStack{
                        Text("HP:")
                            .font(.headline)
                        HealthBarView(currentHealth: $currentHealth)
                            .opacity(healthReduce ? 0.7 : 1)
                            .offset(x: healthReduce ? 10 : 0)
                            .animation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2), value: healthReduce)
                        Text(gameLanguage == "english" ? "Medium Mode" : "Chế độ trung bình")
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
                    Text("\(firstNumber) \(operation.rawValue) \(secondNumber)")
                        .font(.largeTitle)
                        .bold()
                    
                    
                    HStack {
                        ForEach(0..<2) {index in
                            Button {
                                answerIsCorrect(answer: choiceArray[index])
                                generateAnswers()
                            } label: {
                                AnswerButton(number: Double(choiceArray[index]), isCorrect: true)
                            }
                        }
                    }
                    
                    HStack {
                        ForEach(2..<4) {index in
                            Button {
                                answerIsCorrect(answer: choiceArray[index])
                                generateAnswers()
                            } label: {
                                AnswerButton(number: Double(choiceArray[index]), isCorrect: true)
                            }
                        }
                    }
                    Text(gameLanguage == "english" ? "Score: \(score)" : "Điểm: \(score)")
                        .font(.headline)
                        .bold()
                    
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
                    if let correctSoundURL = Bundle.main.url(forResource: "sound-effect-twinklesparkle-115095", withExtension: "mp3"),
                       let incorrectSoundURL = Bundle.main.url(forResource: "negative_beeps-6008", withExtension: "mp3") {
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
                                audioPlayerIncorrect?.play()
                            }
                        }
                        .onChange(of: answerCorrect) { newValue in
                            if newValue {
                                audioPlayerCorrect?.play()
                                answerCorrect = false
                            }
                        }
                        .onChange(of: answerInCorrect) { newValue in
                            if newValue {
                                audioPlayerIncorrect?.play() 
                                answerInCorrect = false
                            }
                        }
                .padding()
                .background(isDarkMode ? .black : .white)
                
        }
        
    }
}


@available(iOS 15.0, *)
struct Game1View_Previews: PreviewProvider {
    static var previews: some View {
        Game1View(userName:.constant(""), gameLanguage: "english")
    }
}
