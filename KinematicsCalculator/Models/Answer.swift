//
//  Answer.swift
//  KinematicsCalculator
//
//  Created by Morgan Harris-Stoertz on 2023-06-05.
//

import Blackbird
import Foundation

struct Answer: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var answer: Double
    @BlackbirdColumn var providedInitialVelocity: Double
    @BlackbirdColumn var providedFinalVelocity: Double
    @BlackbirdColumn var providedDistance: Double
}

