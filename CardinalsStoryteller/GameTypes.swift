//
//  GameTypes.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

enum Type: Int {
    case fight, argument, chase, race, game
}

func getGameType(type: Type) -> GameType {
    let gameType = GameType.init(typeName: typeNames[type.rawValue], buttonNames: buttonNames[type.rawValue], startingScores: startingScores[type.rawValue], scoreAdjustIndex: scoreAdjustIndex[type.rawValue])
    return gameType
}

let typeNames: [String] = ["Fight", "Argument", "Chase", "Race", "Game"]
private let buttonNames: [[String]] = [["Attack", "Feint", "Defend", "Dodge"],
                                       ["", "", "", ""],
                                       ["Sprint", "", "", ""],
                                       ["Push Hard", "Exploit", "Wait", "Make Opening"],
                                       ["Attack", "Trash Talk", "Defend", "Analyze"]]
private let startingScores: [(Int, Int)] = [(10, 10),
                                            (10, 10),
                                            (randomNumber(floor: 5, ceiling: 10), randomNumber(floor: 5, ceiling: 10)),
                                            (10, 10),
                                            (5, 5)]

private let scoreAdjustIndex: [[[(Int, Int)]]] = [
    // Fight
    [[(-1, -1), (-2, 0), (0, 1), (0, 1)],
    [(0, -2), (0, 0), (0, 1), (0, 0)],
    [(1, 0), (1, 0), (1, 1), (1, 0)],
    [(1, -1), (0, 0), (0, 1), (0, 0)]],
    // Argument
    [[(-1, -1), (-2, 0), (0, 1), (0, 1)],
     [(0, -2), (0, 0), (0, 1), (0, 0)],
     [(1, 0), (1, 0), (1, 1), (1, 0)],
     [(1, -1), (0, 0), (0, 1), (0, 0)]],
    // Chase
    [[(-1, -1), (-2, 0), (0, 1), (0, 1)],
     [(0, -2), (0, 0), (0, 1), (0, 0)],
     [(1, 0), (1, 0), (1, 1), (1, 0)],
     [(1, -1), (0, 0), (0, 1), (0, 0)]],
    // Race
    [[(-1, -1), (-2, 0), (0, 1), (0, 1)],
     [(0, -2), (0, 0), (0, 1), (0, 0)],
     [(1, 0), (1, 0), (1, 1), (1, 0)],
     [(1, -1), (0, 0), (0, 1), (0, 0)]],
    // Game
    [[(-1, -1), (-2, 0), (0, 1), (0, 1)],
     [(0, -2), (0, 0), (0, 1), (0, 0)],
     [(1, 0), (1, 0), (1, 1), (1, 0)],
     [(1, -1), (0, 0), (0, 1), (0, 0)]]]

func randomNumber(floor: Int, ceiling: Int) -> Int {
    return Int.random(in: floor..<ceiling)
}
