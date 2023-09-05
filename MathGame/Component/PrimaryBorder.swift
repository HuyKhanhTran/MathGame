//
//  PrimaryBorder.swift
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

struct PrimaryBorder: View {
    var text: String
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        Text(text)
            .frame(width: 350, height: 50)
            .padding(.leading, 4.0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color("AccentColor"), lineWidth: 2)
                    .frame(width: 350, height: 50))
            .foregroundColor(isDarkMode ? .white : .black)
            .padding(.horizontal)
    }
}

struct PrimaryBorder_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryBorder(text: "hi")
    }
}
