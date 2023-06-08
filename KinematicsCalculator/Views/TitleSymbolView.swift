//
//  TitleSymbolView.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-07.
//

import LaTeXSwiftUI
import SwiftUI

struct TitleSymbolView: View {
    //MARK: stored properties
    let title:String
    let symbol:String
    
    //MARK: computed properties
    
    // returns an interface to show a photo with a caption and credit
    
    var body: some View {
        
        
        HStack {
            Text(title)
                .font(.title)
                .bold()
            
            LaTeX(symbol)
                .blockMode(.alwaysInline)
                .font(.title)
                .italic()
            
        }
    }
}

struct TitleSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        TitleSymbolView(title: "Accleration:", symbol: "acceleration")
    }
}
