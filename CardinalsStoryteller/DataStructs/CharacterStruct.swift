//
//  CharacterStruct.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/29/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

struct PlayerCharacter {
    var characterName: String
    var portraitName: String
    var gamesPlaying: [String]
    var color: CharacterColor
    var id: String
    init(characterName: String, portraitName: String, characterColor: CharacterColor) {
        self.characterName = characterName
        self.portraitName = portraitName
        self.color = characterColor
        id = "\(Date.init().hashValue) + \(characterName.hashValue)"
        gamesPlaying = []
    }
    init(characterName: String, portraitName: String, gamesPlaying: [String], characterColor: Int, id: String){
        self.characterName = characterName
        self.portraitName = portraitName
        self.gamesPlaying = gamesPlaying
        self.color = CharacterColor(rawValue: characterColor)!
        self.id = id
    }
}
