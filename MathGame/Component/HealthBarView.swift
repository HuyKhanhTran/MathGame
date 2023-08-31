//
//  HealthBarView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI

struct HealthBarView: View {
    @Binding var currentHealth: Int
    
    var maximumHealth = 5// Maximum health value
    var offImage: Image?// Image for the off state (empty heart
    var onImage = Image(systemName: "heart.fill") // Image for the on state (filled heart)
    var offColor = Color.gray// Color for the off state (empty heart
    var onColor = Color.red// Color for the on state (filled heart)
        
        func image(for number: Int) -> Image {// Function to determine the image based on the number
            if number > currentHealth {
                return offImage ?? onImage
            } else {
                return onImage
            }
        }
    var body: some View {
        ForEach(1..<maximumHealth + 1, id: \.self) {// Display images for each health segment
                   number in image(for: number).foregroundColor(number > currentHealth ? offColor : onColor)
               }
    }
}

struct HealthBarView_Previews: PreviewProvider {
    static var previews: some View {
        HealthBarView(currentHealth: .constant(5))
    }
}
