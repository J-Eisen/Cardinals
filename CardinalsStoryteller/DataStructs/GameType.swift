//
//  GameType.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

struct GameType {
    var typeName: String
    var buttonNames: [String]
    var startingScores: (Int, Int)
    var scoreAdjustIndex: [[(Int, Int)]]
}
