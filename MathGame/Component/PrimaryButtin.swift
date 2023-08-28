//
//  PrimaryButtin.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = Color("AccentColor")
    
    var body: some View {
        VStack{
            Text(text)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(background)
                .cornerRadius(30)
                .shadow(radius: 10)
        }
        
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(text: "Hi")
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
                .previewDisplayName("iPad Pro 11-inch")

            PrimaryButton(text: "Hi")
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
                .previewDisplayName("iPad Pro 12.9-inch")
        }
    }
}

