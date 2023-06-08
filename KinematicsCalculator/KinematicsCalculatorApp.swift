//
//  KinematicsCalculatorApp.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-05.
//

import SwiftUI

@main
struct KinematicsCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
                TabView{
                    PropertyToSolveView()
                        .tabItem{
                            Label("Calculator", systemImage: "circle.grid.3x3")
                        }
                    HistoryView()
                        .tabItem{
                            Label("History", systemImage: "list.star")
                        }
                }
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
