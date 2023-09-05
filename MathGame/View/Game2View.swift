//
//  Game2View.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 21/08/2023.
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
@available(iOS 16.0, *)
struct Game2View: View {
    @Binding var userName: String
    @State private var correctAnswer = 0
    @State private var correctAnswer1 = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var operation: MathOperation = .addition
    @State private var operation1: MathOperation = .addition
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var thirdNumber = 0
    @State private var points = 1000{
        didSet {
            points = min(max(points, 400), 1000)
        }
    }
    @State private var score = 0
    @State private var currentHealth = 5
    @State private var isGameOver: Bool = false
    @State private var highestScore = 0
    @State var gameLanguage: String
    @State private var divisionResult: Double = 0.0
    @State private var divisionResult1: Double = 0.0
    @State private var healthReduce = false
    @Environment(\.dismiss) var dismiss
    @State private var answerCorrect: Bool = false
    @State private var answerInCorrect: Bool = false
    @State private var audioPlayerCorrect: AVAudioPlayer?
    @State private var audioPlayerIncorrect: AVAudioPlayer?
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var timeLeft = 20
    
    func answerIsCorrect(answer: Int){
        print(currentHealth)
        if answer == correctAnswer1 {
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
            //timeLeft = 10
        }
         winGame()
        
    }
    func losingGame(){
        if currentHealth == 0{
            saveHighScore(userName: userName, highestscore: highestScore)
            
            UserDefaults.standard.removeObject(forKey: "savedGameState")
            isGameOver = true
            
        }
    }
    func winGame(){
        if score == 20{
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
        thirdNumber = Int.random(in: 1...(points / 2))

        
        if score < 2 {
            operation = [.addition, .subtraction].randomElement() ?? .addition
        } else if score < 4 {
            operation = [.addition, .subtraction, .multiplication].randomElement() ?? .addition
        } else {
                operation = MathOperation.random()
            }
        
        if score < 3 {
            operation1 = [.addition, .subtraction].randomElement() ?? .addition
        } else if score < 5 {
            operation1 = [.addition, .subtraction, .multiplication].randomElement() ?? .addition
        } else {
                operation1 = MathOperation.random()
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
        switch operation1 {
        case .addition:
            correctAnswer1 = correctAnswer + thirdNumber
        case .subtraction:
            correctAnswer1 = correctAnswer - thirdNumber
        case .multiplication:
            correctAnswer1 = correctAnswer * thirdNumber
        case .division:
            divisionResult1 = Double(correctAnswer) / Double(thirdNumber)
            correctAnswer1 = Int(divisionResult1)
        }


        var answerList = [Int]()

        for _ in 0...2 {
            answerList.append(Int.random(in: -points...points))
        }

        answerList.append(correctAnswer1) // Append the correct answer

        choiceArray = answerList.shuffled()
        winGame()
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
                if score == 20 {
                    WiningView(userName: $userName, highestScore: $highestScore, gameLanguage: gameLanguage)
                } else if isGameOver{
                    GameOverView(userName: $userName, highestScore: $highestScore, gameLanguage: gameLanguage)
                } else {
                    Text(gameLanguage=="english" ? "★Time Left: \(timeLeft)★" : "★Thời gian còn lại: \(timeLeft)★")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
                                        if !isGameOver {
                                            timeLeft -= 1

                                            if timeLeft <= 0 {
                                              currentHealth -= 1
                                                healthReduce = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    healthReduce = false
                                                }
                                                losingGame()
                                                timeLeft = 20 // Reset time limit for the next question
                                            }
                                        }
                                    })
                    HStack{
                        
                        Text("HP:")
                            .font(.headline)
                        HealthBarView(currentHealth: $currentHealth)
                            .opacity(healthReduce ? 0.7 : 1)
                            .offset(x: healthReduce ? 10 : 0)
                            .animation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2), value: healthReduce)
                        
                        Text(gameLanguage == "english" ? "Hard Mode" : "Chế độ khó")
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
                    PrimaryBorder(text:"( \(firstNumber) \(operation.rawValue) \(secondNumber) ) \(operation1.rawValue) \(thirdNumber)")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.largeTitle)
                        .bold()
                    
                    
                    HStack {
                        ForEach(0..<2) {index in
                            Button {
                                answerIsCorrect(answer: choiceArray[index])
                                generateAnswers()
                            } label: {
                                AnswerButton(number: Int(Double(choiceArray[index])), isCorrect: true)
                            }
                        }
                    }
                    
                    HStack {
                        ForEach(2..<4) {index in
                            Button {
                                answerIsCorrect(answer: choiceArray[index])
                                generateAnswers()
                            } label: {
                                AnswerButton(number: Int(Double(choiceArray[index])), isCorrect: true)
                            }
                        }
                    }
                    PrimaryButton(text: gameLanguage == "english" ? "Score: \(score)" : "Điểm: \(score)")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                }
                
            }
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
            .onAppear {
                if let correctSoundURL = Bundle.main.url(forResource: "sound-effect-twinklesparkle-115095", withExtension: "mp3"),
                   let incorrectSoundURL = Bundle.main.url(forResource: "negative_beeps-6008", withExtension: "mp3") {
                    do {
                        audioPlayerCorrect = try AVAudioPlayer(contentsOf: correctSoundURL)
                        audioPlayerIncorrect = try AVAudioPlayer(contentsOf: incorrectSoundURL)
                    } catch {
                        print("Error loading or playing sound effect:", error.localizedDescription)
                    }
                    generateAnswers()
                    
                }
                
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
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct Game2View_Previews: PreviewProvider {
    static var previews: some View {
        Game2View(userName: .constant(""), gameLanguage: "english")
    }
}
