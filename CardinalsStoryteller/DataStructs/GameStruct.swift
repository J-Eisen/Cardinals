//
//  GameStruct.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/29/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

struct Game {
    var saveDate: Date
    var gameName: String
    var player1ID: String
    var player2ID: String
    var type: GameType
    var id: String
    init(gameName: String, player1: String, player2: String, type: GameType) {
        saveDate = Date.init()
        self.gameName = gameName
        self.player1ID = player1
        self.player2ID = player2
        self.type = type
        id = "\(saveDate.hashValue) + \(gameName.hashValue)"
    }
    init(gameName: String, player1: String, player2: String, saveDate: Date, type: Int, id: String) {
        self.saveDate = saveDate
        self.gameName = gameName
        self.player1ID = player1
        self.player2ID = player2
        self.type = getGameType(type: Type(rawValue: type)!)
        self.id = id
    }
}
