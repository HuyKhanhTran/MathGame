//
//  PrimaryButtin.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 18/08/2023.
//

import SwiftUI

struct PrimaryButton: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var text: String
    var background: Color = Color("AccentColor")
    
    var body: some View {
        VStack{
            Text(text)
                .foregroundColor(isDarkMode ? .black : .white)
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
      
            PrimaryButton(text: "Hi")
              
    }
}

