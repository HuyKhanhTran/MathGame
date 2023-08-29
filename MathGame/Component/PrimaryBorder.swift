//
//  PrimaryBorder.swift
//  MathGame
//
//  Created by Khanh, Tran Huy on 29/08/2023.
//

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
