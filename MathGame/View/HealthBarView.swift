//
//  HealthBarView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
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

struct HealthBarView: View {
    @Binding var currentHealth: Int
    
    var maximumHealth = 5
    var offImage: Image?
        var onImage = Image(systemName: "heart.fill")
        var offColor = Color.gray
        var onColor = Color.red
        
        func image(for number: Int) -> Image {
            if number > currentHealth {
                return offImage ?? onImage
            } else {
                return onImage
            }
        }
    var body: some View {
        ForEach(1..<maximumHealth + 1, id: \.self) {
                   number in image(for: number).foregroundColor(number > currentHealth ? offColor : onColor)
               }
    }
}

struct HealthBarView_Previews: PreviewProvider {
    static var previews: some View {
        HealthBarView(currentHealth: .constant(5))
    }
}
