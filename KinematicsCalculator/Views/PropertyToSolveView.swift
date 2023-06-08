//
//  PropertyToSolveView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-07.
//

import SwiftUI

struct PropertyToSolveView: View {
    var body: some View {
        
        NavigationView{
            VStack{
                VStack{
                    Text("Select property to solve for")
                        .bold()
                        .font(.title2)
                    List{
                        NavigationLink(destination: {
                            UnknownPropertyListView()
                        }, label: {
                            TitleSymbolView(title: "Distance", symbol: "$$\\Delta x$$")
                        })
                        NavigationLink(destination: {
                            UnknownPropertyListView()
                        }, label: {
                            TitleSymbolView(title: "Acceleration", symbol: "$$a$$")
                        })
                        NavigationLink(destination: {
                            UnknownPropertyListView()
                        }, label: {
                            TitleSymbolView(title: "Time", symbol: "$$t$$")
                        })
                        NavigationLink(destination: {
                            UnknownPropertyListView()
                        }, label: {
                            TitleSymbolView(title: "Initial Velocity", symbol: "$$V0$$")
                        })
                        NavigationLink(destination: {
                            UnknownPropertyListView()
                        }, label: {
                            TitleSymbolView(title: "Final Velocity", symbol: "$$V$$")
                        })
                       
                    }
                }
            }
            .navigationTitle("Kinematics Calculator")
            
        }
    }
}

struct PropertyToSolveView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyToSolveView()
    }
}
