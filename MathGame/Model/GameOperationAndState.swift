//
//  GameOperationAndState.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 24/08/2023.
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
import Foundation
import SwiftUI
enum MathOperation: String, CaseIterable {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case division = "÷"

    static func random() -> MathOperation {
        return MathOperation.allCases.randomElement()!
    }
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}




struct GameState: Codable {
    let score: Int
    let currentHealth: Int
}
