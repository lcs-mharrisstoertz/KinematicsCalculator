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
        let acceleration = ((finalVelocityToCalculateWith - initalVelocityToCalculateWith)/(distanceToCalculateWith * 2))
        
        //return formatted answer
        return acceleration.formatted(.number.precision(.fractionLength(4)))
        
    }

    
    var initialVelocityString: String {
        if initialVelocity == "" {
            return "V"
        } else {
            return "\(initialVelocity)"
        }
    }
    
    var finalVelocityString: String {
        if finalVelocity == "" {
            return "V0"
        } else {
            return "\(finalVelocity)"
        }
    }
    
    var distanceString: String {
        if distance == "" {
            return "Δx"
        } else {
            return "\(distance)"
        }
    }
    
    var body: some View {
        VStack{
            LaTeX("$$\(finalVelocityString)^2=\(initialVelocityString)^2+2a(\(distanceString))$$")
                .font(.title)
                .bold()
            
                .padding()
            
            //initial velocity text field
            Group{
                HStack{
                    Text("Initial Velocity (m/s)")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                TextField("Enter a number...", text: $initialVelocity)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                  
            }
           
            //final velocity text field
            
            Group{
                HStack{
                    Text("Final Velocity (m/s)")
                        .font(.title2)
                        .bold()
                    Spacer()

                }
                
                TextField("Enter a number...", text: $finalVelocity)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
          //distance text field
            
            Group{
                HStack{
                    Text("Distance (m)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    
                }

                TextField("Enter a number...", text: $distance)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
           Spacer()
            
          //Shows answer
            
            Group{
                HStack{
                    Text("Acceleration:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    LaTeX("\(formattedAccelerationValue) $$m/s^2$$")
                        .blockMode(.alwaysInline)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
            }
            
            Spacer()
            
            //Button to save work
            Button(action: {
                Task{
                    //write to the data base
                    try await db!.transaction { core in
                        try core.query("INSERT INTO Answer (answer,providedInitialVelocity, providedFinalVelocity, providedDistance) VALUES (?, ?, ?, ?)", formattedAccelerationValue, initialVelocityString, finalVelocityString, distanceString)
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

struct AccelerationCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AccelerationCalculatorView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }

    }
}
