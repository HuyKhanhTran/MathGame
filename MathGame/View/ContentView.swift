//
//  ContentView.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    var body: some View {
            VStack{
                MenuView(userName: .constant(""))
                
            }
        }
            
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
        
    }
}

