//
//  UIFunctions.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

func getColor(color: CharacterColor) -> UIColor {
    let colorArray: [[CGFloat]] = [[0.6667, 0.5, 1, 1.0],       // blue
                                   [0, 0.51, 1, 1.0],           // red
                                   [0.3417, 0.68, 0.91, 1.0],   // green
                                   [0.1667, 0.66, 1, 1.0],      // yellow
                                   [0.7583, 0.56, 1, 1.0],      // purple
                                   [0.1167, 0.69, 1, 1.0],      // orange
                                   [0, 0, 0.87, 1.0],           // gray
                                   [0, 0, 1, 1.0]]              // white
    let color = UIColor(hue: colorArray[color.rawValue][0], saturation: colorArray[color.rawValue][1], brightness: colorArray[color.rawValue][2], alpha: colorArray[color.rawValue][3])
    return color
}
