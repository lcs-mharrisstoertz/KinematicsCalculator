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
    
    @State var initialVelocity = ""
    @State var finalVelocity = ""
    @State var distance = ""
    
    
    //MARK: computed properties
    //convert initial velocity given into an optional double
    var initialVelocityAsOptionalDouble: Double?{
        
        guard let initialVelocityGivenAsDouble = Double(initialVelocity) else {
            return nil
        }
        return initialVelocityGivenAsDouble
    }
    
    //convert final velocity given into an optional double
    var finalVelocityAsOptionalDouble: Double?{
        
        guard let finalVelocityGivenAsDouble = Double(finalVelocity) else {
            return nil
        }
        return finalVelocityGivenAsDouble
    }
    
    //convert distance given into an optional double
    var distanceAsOptionalDouble: Double?{
        
        guard let distanceGivenAsDouble = Double(distance) else {
            return nil
        }
        return distanceGivenAsDouble
    }
    

    //answer
    //make initialVelocity usable
    var formattedAccelerationValue: String{
        guard let initalVelocityToCalculateWith = initialVelocityAsOptionalDouble else{
            return "Please enter a numeric value"
        }

        //make finalVelocity usable
            guard let finalVelocityToCalculateWith = finalVelocityAsOptionalDouble else{
                return "Please enter a numeric value"
            }
        
        //make distance usable
            guard let distanceToCalculateWith = distanceAsOptionalDouble else{
                return "Please enter a numeric value"
            }
        //CALCUALTE ANSWER
        let acceleration = ((finalVelocityToCalculateWith - initalVelocityToCalculateWith)/(distanceToCalculateWith)) * 0.5
        
        //return formatted answer
        return acceleration.formatted(.number.precision(.fractionLength(1)))
        
    }

    
    var initialVelocityString: String {
        if initialVelocity == 0.0 {
            return "V"
        } else {
            return "\(initialVelocity)"
        }
    }
    
    var finalVelocityString: String {
        if finalVelocity == 0.0 {
            return "V0"
        } else {
            return "\(finalVelocity)"
        }
    }
    
    var distanceString: String {
        if distance == 0.0 {
            return "Δx"
        } else {
            return "\(distance)"
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                LaTeX("$$\(finalVelocityString)^2=\(initialVelocityString)^2+2a(\(distanceString))$$")
                    .font(.title)
                    .bold()
                
                    .padding()
                
                //initial velocity slider
                Group{
                    HStack{
                        Text("Initial Velocity (m/s)")
                            .font(.title3)
                            .bold()
                        Text("\(initialVelocity.formatted(.number.precision(.significantDigits(4))))")
                    }
                   

                    Slider(value: $initialVelocity, in: 0...100, step: 1.0, label: { Text("Initial Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                    
                    TextField("Enter a number...", text: $initialVelocity)
                        .font(.largeTitle)
                        .padding()
                }
               
                //final velocity slider
                
                Group{
                    HStack{
                        Text("Final Velocity (m/s)")
                            .font(.title3)
                            .bold()
                        Text("\(finalVelocity.formatted(.number.precision(.significantDigits(4))))")
                    }
                   
                    
                    Slider(value: $finalVelocity, in: 0...100, step: 1.0,  label: { Text("Final Velocity")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                    
                    TextField("Enter a number...", text: $finalVelocity)
                        .font(.largeTitle)
                        .padding()
                }
              //distance slider
                
                Group{
                    HStack{
                        Text("Distance (m)")
                            .font(.title3)
                            .bold()
                        Text("\(distance.formatted(.number.precision(.significantDigits(4))))")
                        
                    }
                    
                    Slider(value: $distance, in: 0...100, step: 1.0, label: { Text("distance")}, minimumValueLabel: {Text("0")}, maximumValueLabel: {Text("100")})
                    
                    TextField("Enter a number...", text: $distance)
                        .font(.largeTitle)
                        .padding()
                }
                
              //Shows answer
                
                Group{
                    LaTeX("Acceleration:$$\(answer.formatted(.number.precision(.significantDigits(4))))m/s^2$$")
                        .blockMode(.alwaysInline)
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
                    Text("Save to History")
                        .font(.title2)
                        .bold()
                })
                .tint(.green)
                .buttonStyle(.borderedProminent)
                

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
