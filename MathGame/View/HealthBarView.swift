//
//  HealthBarView.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

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
