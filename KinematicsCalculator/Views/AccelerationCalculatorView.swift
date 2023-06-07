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
        NavigationView{
            VStack{
                LaTeX("$$\(finalVelocityString)^2=\(initialVelocityString)^2+2a(\(distanceString))$$")
                    .font(.title)
                    .bold()
                
                    .padding()
                
                //initial velocity text field
                Group{
                    HStack{
                        Text("Initial Velocity (m/s)")
                            .font(.title3)
                    }
                    
                    TextField("Enter a number...", text: $initialVelocity)
                        .font(.largeTitle)
                        .padding()
                }
               
                //final velocity text field
                
                Group{
                    HStack{
                        Text("Final Velocity (m/s)")
                            .font(.title3)
                            .bold()

                    }
                    
                    TextField("Enter a number...", text: $finalVelocity)
                        .font(.largeTitle)
                        .padding()
                }
              //distance text field
                
                Group{
                    HStack{
                        Text("Distance (m)")
                            .font(.title3)
                            .bold()
                        
                    }

                    TextField("Enter a number...", text: $distance)
                        .font(.largeTitle)
                        .padding()
                }
                
              //Shows answer
                
                Group{
                    HStack{
                        Text("Acceleration:")
                            .font(.title2)
                            .bold()
                        LaTeX("\(formattedAccelerationValue) $$m/s^2$$")
                            .blockMode(.alwaysInline)
                            .font(.title3)
                    }
                }
                
                //Button to save work
                Button(action: {
                    Task{
                        //write to the data base
                        try await db!.transaction { core in
                            try core.query("INSERT INTO Answer (answer) VALUES (?)", formattedAccelerationValue)
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
