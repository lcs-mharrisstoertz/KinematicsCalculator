//
//  ContentView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-05.
//
import LaTeXSwiftUI
import SwiftUI


struct ContentView: View {
    @State var a = 0.0
    var body: some View {
        VStack {
            LaTeX("Pythagorean Theorem: $$\(a)^2 + b^2 = c^2$$")
            
            Slider(value: $a, in: 0...100, step: 1.0)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
