//
//  GameOperationAndState.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 24/08/2023.
//

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
