//
//  UnknownPropertyListView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-07.
//

import SwiftUI

struct UnknownPropertyListView: View {
    var body: some View {
        List{
            NavigationLink(destination: {
                AccelerationCalculatorView()
            }, label: {
                TitleSymbolView(title: "Distance", symbol: "$$Δx$$")
            })
            NavigationLink(destination: {
                AccelerationCalculatorView()
            }, label: {
                TitleSymbolView(title: "Initial Velocity", symbol: "$$V0$$")
            })
            NavigationLink(destination: {
                AccelerationCalculatorView()
            }, label: {
                TitleSymbolView(title: "Final Velocity", symbol: "$$V$$")
            })
            NavigationLink(destination: {
                AccelerationCalculatorView()
            }, label: {
                TitleSymbolView(title: "Time", symbol: "$$t$$")
            })
            
        }
        .navigationTitle("Select Unknown Value")
    }
}

struct UnknownPropertyListView_Previews: PreviewProvider {
    static var previews: some View {
        UnknownPropertyListView()
    }
}
