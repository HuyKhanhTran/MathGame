//
//  PrimaryButton.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 29/08/2023.
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
