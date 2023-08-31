//
//  ScoreData.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 19/08/2023.
//

import Foundation
import SwiftUI

// A struct to hold user's score data
struct ScoreData: Codable {
    var userName: String
    var score: Int
}
// A singleton class to manage user scores
class ScoreManager {
    static let shared = ScoreManager() // Singleton instance
    
    private var scores: [ScoreData] = []
    private let scoresFileName = "scoredata.txt"
    
    private init() {// Private initializer to enforce singleton pattern and load scores
        loadScores()
    }
    
    private func loadScores() {  // Load scores from the file
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(scoresFileName)
            
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = fileContents.split(separator: "\n")
            
            for line in lines {
                let components = line.split(separator: ",")
                if components.count == 2, let userName = components.first, let score = Int(components.last!) {
                    let newScore = ScoreData(userName: String(userName), score: score)
                    scores.append(newScore)
                }
            }
        } catch {
            print("Error loading scores: \(error)")
        }
    }
    
    private func saveScores() { // Save scores to the file
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(scoresFileName)
            
            var fileContents = ""
            for score in scores {
                let scoreLine = "\(score.userName),\(score.score)\n"
                fileContents += scoreLine
            }
            
            try fileContents.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving scores: \(error)")
        }
    }
    
    func addScore(userName: String, score: Int) {// Add a score to the manager
            if let existingScoreIndex = scores.firstIndex(where: { $0.userName == userName }) {
                // Update the score for the existing user if it's higher
                if score > scores[existingScoreIndex].score {
                    scores[existingScoreIndex].score = score
                }
            } else {
                // Add a new score for a new user
                let newScore = ScoreData(userName: userName, score: score)
                scores.append(newScore)
            }
            
            saveScores()
        }
    


    func updateHighestScore(userName: String, newScore: Int) { // Update the highest score for a user
        if let existingScoreIndex = scores.firstIndex(where: { $0.userName == userName }) {
            if newScore > scores[existingScoreIndex].score {
                scores[existingScoreIndex].score = newScore
                saveScores()
            }
        } else {
            // If the user doesn't exist in the scores array, add a new score
            addScore(userName: userName, score: newScore)
        }
    }

    
    func getLeaderboard() -> [ScoreData] {// Get the leaderboard sorted by score
        return scores.sorted { $0.score > $1.score }
    }
    func removeScore(userName: String) { // Remove a user's score
        if let index = scores.firstIndex(where: { $0.userName == userName }) {
            scores.remove(at: index)
            saveScores()
        }
    }

    
}

