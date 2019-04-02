//
//  SelectCharacterViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/16/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "CharacterCell"
private let headerReuseIdentifier = "AddNewHeader"
private let newGameSegueIdentifier = "SelectCharacterToNewGame"
private let welcomeSegueIdentifier = "ReturnToWelcomeFromSelectCharacter"
private let smallCell: CGFloat = 160
private let largeCell: CGFloat = 176

class SelectCharacterViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characterArray: [PlayerCharacter] = []
    var selectedPlayer: Int!
    var tempCharacter: PlayerCharacter!
    var characterSelectNumber: Int!
    var lastVC: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        characterArray = loadCharacterArray()
        collectionView.layoutIfNeeded()
        collectionView!.register(CharacterCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewGameViewController {
            let vc = segue.destination as! NewGameViewController
            if sender is UIBarButtonItem {
                let button = sender as! UIBarButtonItem
                if button.title == "Done" {
                    tempCharacter = characterArray[characterSelectNumber]
                }
            }
            if characterSelectNumber == 1 {
                vc.player1 = tempCharacter
            } else if characterSelectNumber == 2 {
                vc.player2 = tempCharacter
            }
        }
    }
    
    @IBAction func tapNavBarButton(_ sender: UIBarButtonItem) {
        if lastVC == "Welcome" {
            performSegue(withIdentifier: welcomeSegueIdentifier, sender: sender)
        } else if lastVC == "NewGame" {
            performSegue(withIdentifier: newGameSegueIdentifier, sender: sender)
        }
    }
}

extension SelectCharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CharacterCell
        cell.characterName.text = characterArray[indexPath.item].characterName
        cell.portraitImage.image = UIImage.init(named: characterArray[indexPath.item].portraitName)
        cell.backgroundColor = getColor(color: characterArray[indexPath.item].color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        header.isHidden = false
        return header
    }
}

extension SelectCharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CharacterCell
        if selectedPlayer != nil {
            var lastIndexPath = indexPath
            lastIndexPath.item = selectedPlayer
            let lastCell = collectionView.cellForItem(at: lastIndexPath) as! CharacterCell
            lastCell.bounds.size.width = smallCell
            lastCell.bounds.size.height = smallCell
        }
        selectedCell.bounds.size.width = largeCell
        selectedCell.bounds.size.height = largeCell
        
        selectedPlayer = indexPath.item
        return true
    }
}

