//
//  NewGameViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/29/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

private let segueIdentifier = "SegueToSelectNewCharacter"

class NewGameViewController: UIViewController {
    @IBOutlet weak var portrait1ImageView: UIImageView!
    @IBOutlet weak var portrait2ImageView: UIImageView!
    @IBOutlet weak var characterName1Label: UILabel!
    @IBOutlet weak var characterName2Label: UILabel!
    @IBOutlet weak var gameNameTextField: UITextField!
    
    var characterSelectNumber: Int!
    var player1: PlayerCharacter!
    var player2: PlayerCharacter!
    var gameName: String!
    var selectedGame: Int = 0
    private let portraits = ["Blue", "Pink", "Purple", "Orange", "Default"]
    private let colors: [CharacterColor] = [.blue, .red, .purple, .orange, .gray]
    
    private let randNums: (Int, Int) = (randomNumber(floor: 0, ceiling: 4), randomNumber(floor: 0, ceiling: 4))
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if player1 != nil {
            portrait1ImageView.image = UIImage.init(named: player1.portraitName)
            portrait1ImageView.backgroundColor = getColor(color: player1.color)
            characterName1Label.text = player1.characterName
            characterName1Label.textColor = getColor(color: player1.color)
        } else {
            portrait1ImageView.image = UIImage.init(named: portraits[randNums.0])
            characterName1Label.text = "Player 1"
            characterName1Label.textColor = getColor(color: colors[randNums.0])
        }
        if player2 != nil {
            portrait2ImageView.image = UIImage.init(named: player2.portraitName)
            portrait2ImageView.backgroundColor = getColor(color: player2.color)
            characterName2Label.text = player2.characterName
            characterName2Label.textColor = getColor(color: player2.color)
        } else {
            portrait2ImageView.image = UIImage.init(named: portraits[randNums.1])
            characterName2Label.text = "Player 2"
            characterName2Label.textColor = getColor(color: colors[randNums.1])
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gameName = gameNameTextField.text!
        if segue.destination is SelectCharacterViewController {
            let vc = segue.destination as! SelectCharacterViewController
            vc.characterSelectNumber = characterSelectNumber
            vc.lastVC = "NewGame"
            vc.characterArray = loadCharacterArray()
        } else if segue.destination is MainGameViewController {
            let newGameType = getGameType(type: Type(rawValue: selectedGame)!)
            let newGame = Game.init(gameName: gameName, player1: player1.characterName, player2: player2.characterName, type: newGameType)
            addGame(newGame: newGame, player1: player1, player2: player2)
            let vc = segue.destination as! MainGameViewController
            vc.game = newGame
            if player1 == nil {
                player1 = PlayerCharacter.init(characterName: "Player 1", portraitName: portraits[randNums.0], characterColor: colors[randNums.0])
            }
            if player2 == nil {
                player2 = PlayerCharacter.init(characterName: "Player 2", portraitName: portraits[randNums.1], characterColor: colors[randNums.1])
            }
            vc.player1 = player1
            vc.player2 = player2
        }
    }
 

    @IBAction func tapPortrait(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: sender.view)
        print("Tap")
        print("X: \(tapLocation.x) | Y: \(tapLocation.y)")
        if (tapLocation.x >= portrait1ImageView.bounds.minX && tapLocation.x <= portrait1ImageView.bounds.maxX)
            && (tapLocation.y >= characterName1Label.bounds.minX && tapLocation.y <= portrait1ImageView.bounds.maxY) {
            characterSelectNumber = 1
        } else if (tapLocation.x >= portrait2ImageView.bounds.minX && tapLocation.x <= portrait2ImageView.bounds.maxX)
            && (tapLocation.y >= characterName2Label.bounds.minX && tapLocation.y <= portrait2ImageView.bounds.maxY) {
            characterSelectNumber = 2
        }
        print("Character Select Number: \(String(describing: characterSelectNumber))")
        performSegue(withIdentifier: segueIdentifier, sender: sender)
    }
}

// MARK: - Picker View

extension NewGameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeNames[row]
    }
    
}

extension NewGameViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGame = row
    }
}

// MARK: - TextField Functions

extension NewGameViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameNameTextField.resignFirstResponder()
        if gameName != nil {
            gameNameTextField.text = gameName
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil {
            gameName = textField.text
        }
    }
}
