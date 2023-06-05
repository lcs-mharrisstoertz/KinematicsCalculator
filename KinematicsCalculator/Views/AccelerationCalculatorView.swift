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
        
        VStack{
                LaTeX("$$V^2=V^20+2a∆x$$")
                .font(.title)
                .bold()
        }
        
        .navigationTitle("Acceleration")
    }
}

struct AccelerationCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        AccelerationCalculatorView()
    }
}
