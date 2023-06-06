//
//  AccelerationCalculatorView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-05.
//

import Blackbird
import SwiftUI
import LaTeXSwiftUI

struct AccelerationCalculatorView: View {
    //MARK: stored properties
    //input from user
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @State var initialVelocity = 0.0
    @State var finalVelocity = 0.0
    @State var distance = 0.0
    
    
    //MARK: computed properties
    var answer: Double{
        ((finalVelocity - initialVelocity)/(distance)) * 0.5
    }
    
    var initialVelocityString: String {
        if initialVelocity == 0.0 {
            return "V"
        } else {
            return "\(initialVelocity)"
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                LaTeX("$$\(finalVelocity)^2=\(initialVelocityString)^2+2a(\(distance))$$")
                    .font(.title)
                    .bold()
                
                    .padding()
                
                //initial velocity slider
                Group{
                    Text("Initial Velocity (m/s)")
                        .font(.title3)
                        .bold()

                    Slider(value: $initialVelocity, in: 0...100, step: 1.0, label: { Text("Initial Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                }
               
                //final velocity slider
                
                Group{
                    Text("Final Velocity (m/s)")
                        .font(.title3)
                        .bold()
                    
                    Slider(value: $finalVelocity, in: 0...100, step: 1.0,  label: { Text("Final Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                }
              //distance slider
                
                Group{
                    Text("Distance (m)")
                        .font(.title3)
                        .bold()
                    
                    Slider(value: $distance, in: 0...100, step: 1.0, label: { Text("distance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                }
                
              //Shows answer
                
                Group{
                    LaTeX("$$Acceleration:\(answer.formatted(.number.precision(.significantDigits(3))))m/s^2$$")
                        .bold()
                        .font(.title2)
                        .padding()
                }
                
                //Button to save work
                Button(action: {
                    Task{
                        //write to the data base
                        try await db!.transaction { core in
                            try core.query("INSERT INTO Answer (answer) VALUES (?)", answer)
                        }
                    }
                }, label: {
                    Text("ADD")
                        .font(.caption)
                })
                .tint(.green)
                .buttonStyle(.borderedProminent)
                
                //History
                
                Group{
                    Text("History")
                        .font(.title)
                        .bold()
                    
                    List{
                        
                    }
                }
                
                

               Spacer()
                
            }
            .padding()
            .navigationTitle("Acceleration")
        }

    }
}

struct AccelerationCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        AccelerationCalculatorView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
