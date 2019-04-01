//
//  MainGameFunctions.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

private func getChoiceIndex(choice1: Choice, choice2: Choice) -> (Int, Int) {
    var choiceIndex: (Int, Int)!
    for index in 0...1 {
        var choice: Choice!
        if index == 0 {
            choice = choice1
        } else {
            choice = choice2
        }
        switch choice! {
        case .north:
            if index == 0 {
                choiceIndex.0 = 0
            } else {
                choiceIndex.1 = 0
            }
            break
        case .east:
            if index == 0 {
                choiceIndex.0 = 1
            } else {
                choiceIndex.1 = 1
            }
            break
        case .south:
            if index == 0 {
                choiceIndex.0 = 2
            } else {
                choiceIndex.1 = 2
            }
            break
        case .west:
            if index == 0 {
                choiceIndex.0 = 3
            } else {
                choiceIndex.1 = 3
            }
            break
        }
    }
    return choiceIndex
}

private func getScore(gameType: GameType, choiceIndex: (Int, Int)) -> (Int, Int) {
    let scores = gameType.scoreAdjustIndex[choiceIndex.0][choiceIndex.1]
    return scores
}

func updateScore(choice1: Choice, choice2: Choice, gameType: GameType) -> (Int, Int) {
    let choiceIndex = getChoiceIndex(choice1: choice1, choice2: choice2)
    let scores = getScore(gameType: gameType, choiceIndex: choiceIndex)
    return scores
}
