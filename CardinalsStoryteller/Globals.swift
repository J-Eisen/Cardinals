//
//  Globals.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/16/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import Foundation

var testMode: Bool = false
let portraitArray: [String] = []
let unknownPortraitArray: [String] = ["Default", "Blue", "Pink", "Orange", "Purple"]
let maxF = 6
let maxM = 5

enum Choice: String {
    case north, east, south, west
}

enum CharacterColor: Int {
    case blue, red, green, yellow, purple, orange, gray, white
}
