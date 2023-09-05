//
//  ContentView.swift
//  MathGame
//
//  Created by Federico on 04/11/2021.
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

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
            VStack{
                MenuView(userName: .constant(""))
                
            }
        }
            
}

@available(iOS 15.0, *)
@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
        
    }
}

