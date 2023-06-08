//
//  HistoryView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-06.
//

import Blackbird
import SwiftUI

struct HistoryView: View {
    
    //MARK: stored properties
    @BlackbirdLiveModels({ db in
        try await Answer.read(from: db)
    }) var savedAnswers
    
    //MARK: computed properties
    var body: some View {
        NavigationView{
            
            VStack {
                List{
                    ForEach(savedAnswers.results){currentAnswer in
                        VStack(alignment: .leading){
                            //Show input
                            Text("Input Provided:")
                                .bold()
                            Text("Intial Velocity: \(currentAnswer.providedInitialVelocity)")
                            Text("Final Velocity:  \(currentAnswer.providedFinalVelocity)")
                            Text("Distance: \(currentAnswer.providedDistance)")
                            
                            //Show answer
                            Text("Answer: \(currentAnswer.answer)")
                                .bold()
                                .font(.title3)
                        }
                        
                    }
                    .onDelete(perform: removeRows)
                }
            }
            .navigationTitle("Answers")
        }
        
    }
    
    //MARK: Functions
    func removeRows(at offsets: IndexSet){
        for offset in offsets{
            print(offset)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

