//
//  AccelerationCalculatorView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-05.
//

import SwiftUI
import LaTeXSwiftUI

struct AccelerationCalculatorView: View {
    //MARK: stored properties
    //input from user
    @State var initialVelocity = 0.0
    @State var finalVelocity = 0.0
    @State var distance = 0.0
    
    var body: some View {
        NavigationView{
            VStack{
                LaTeX("$$V^2=V^20+2a∆x$$")
                    .font(.title)
                    .bold()
                
                LaTeX("$$\(finalVelocity)^2=\(initialVelocity)^2+2a(\(distance))$$")
                    .font(.title)
                    .bold()
                
                
                Slider(value: $initialVelocity, in: 0...100, step: 1.0, label: { Text("Initial Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                
                Slider(value: $finalVelocity, in: 0...100, step: 1.0,  label: { Text("Final Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                
                Slider(value: $distance, in: 0...100, step: 1.0, label: { Text("distance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                
            }
            .navigationTitle("Acceleration")
        }

    }
}

struct AccelerationCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        AccelerationCalculatorView()
    }
}
