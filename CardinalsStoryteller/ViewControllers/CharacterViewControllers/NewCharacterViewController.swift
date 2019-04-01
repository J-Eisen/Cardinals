//
//  NewCharacterViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/16/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

private let saveSegueIdentifier = "ReturnToSelectCharacterSave"
private let cancelSegueIdentifier = "ReturnToSelectCharacterCancel"
private let portraitSegueIdentifier = "SegueToPortraitCollection"

class NewCharacterViewController: UIViewController {
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var saveButton: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var imageName: String = "Default"
    var characterName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        portrait.image = UIImage.init(named: imageName)
        if characterName != "" {
            nameTextField.text = characterName
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PortraitCollectionViewController {
            let vc = segue.destination as! PortraitCollectionViewController
            vc.selectedImageName = imageName
            vc.tempCharacterName = characterName
        } else if segue.destination is SelectCharacterViewController {
            let vc = segue.destination as! SelectCharacterViewController
            if segue.identifier == saveSegueIdentifier {
                vc.characterArray.append(makeNewCharacter())
            }
        }
    }
    
    @IBAction func tapPortrait(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: super.view)
        if (tapLocation.x >= portrait.bounds.minX && tapLocation.x <= portrait.bounds.maxX)
        && (tapLocation.y >= portrait.bounds.minY && tapLocation.y <= portrait.bounds.maxY) {
            performSegue(withIdentifier: portraitSegueIdentifier, sender: sender)
            print("Tap - X: \(tapLocation.x), Y: \(tapLocation.y)")
            print("Portrait Bounds")
            print("minX: \(portrait.bounds.minX) maxX: \(portrait.bounds.maxX)")
            print("minY: \(portrait.bounds.minY) maxY: \(portrait.bounds.maxY)")
        }
    }
    
    /*@IBAction func tapCheck(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.view)
        if (tapLocation.x >= saveButton.bounds.minX && tapLocation.x <= saveButton.bounds.maxX)
            && (tapLocation.y >= saveButton.bounds.minY && tapLocation.y <= saveButton.bounds.maxY) {
            performSegue(withIdentifier: saveButtonIdentifier, sender: sender)
        }
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        super.touchesBegan(touches, with: event)
    }
}

extension NewCharacterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil {
            characterName = textField.text!
        }
    }
}

extension NewCharacterViewController {
    func makeNewCharacter() -> PlayerCharacter {
        let characterColor: CharacterColor = CharacterColor(rawValue: randomNumber(floor: 0, ceiling: 7)) ?? CharacterColor.white
        let newCharacter = PlayerCharacter.init(characterName: characterName, portraitName: imageName, characterColor: characterColor)
        return newCharacter
    }
}
