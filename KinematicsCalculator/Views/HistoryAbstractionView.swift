//
//  HistoryAbstractionView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-09.
//

import SwiftUI

struct HistoryAbstractionView: View {
    
    //MARK: stored properties
    let result: Answer
    
    //MARK: computed properties
    var body: some View {
        VStack(alignment: .leading){
            //Show input
            Text("Input Provided:")
                .bold()
            Text("Intial Velocity: \(result.providedInitialVelocity)")
            Text("Final Velocity:  \(result.providedFinalVelocity)")
            Text("Distance: \(result.providedDistance)")
            
            //Show answer
            Text("Answer: \(result.answer)")
                .bold()
                .font(.title3)
        }
    }
}

struct HistoryAbstractionView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryAbstractionView(result: Answer(id: 1, answer: 2.2, providedInitialVelocity: 2.2, providedFinalVelocity: 2.2, providedDistance: 2.2))
    }
}
