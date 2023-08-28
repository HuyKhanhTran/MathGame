//
//  MathGameApp.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI

@available(iOS 15.0, *)
@available(iOS 16.0, *)
@main
struct MathGameApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
        }
    }
    
}
