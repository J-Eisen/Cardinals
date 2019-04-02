//
//  MainGameViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    var game: Game!
    var player1: PlayerCharacter!
    var player2: PlayerCharacter!
    var scores: (Int, Int)!
    var choices: (Choice, Choice)!
    var turnEnd: Bool = false

    @IBOutlet weak var player1Portrait: UIImageView!
    @IBOutlet weak var player2Portrait: UIImageView!
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    
    @IBOutlet weak var scoreBar: UIProgressView!
    
    @IBOutlet var gameButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpPlayers()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonTapped(_ sender: UIButton) {
        let selectedChoice: Choice = Choice(rawValue: sender.restorationIdentifier!)!
        if !turnEnd {
            choices.0 = selectedChoice
        } else if turnEnd {
            choices.1 = selectedChoice
            scores = updateScore(choice1: choices.0, choice2: choices.1, gameType: game.type)
            updateScoreBar()
            turnEnd = false
        }
    }
    
    func setUpPlayers(){
        player1Portrait.image = UIImage.init(named: player1.portraitName)
        player1Portrait.backgroundColor = getColor(color: player1.color)
        player2Portrait.image = UIImage.init(named: player2.portraitName)
        player2Portrait.backgroundColor = getColor(color: player2.color)
        
        player1NameLabel.text = player1.characterName
        player1NameLabel.textColor = getColor(color: player1.color)
        player2NameLabel.text = player2.characterName
        player2NameLabel.textColor = getColor(color: player2.color)
    }
    
    func setUpScores() {
        scores.0 = game.type.startingScores.0
        scores.1 = game.type.startingScores.1
        scoreBar.progressTintColor = getColor(color: player1.color)
        scoreBar.trackTintColor = getColor(color: player2.color)
        updateScoreBar()
    }
    
    func updateScoreBar() {
        scoreBar.progress = Float(scores.0/(scores.0 + scores.1))
    }
    
    func setUpButtons(){
        for index in 0...gameButtonCollection.count {
            gameButtonCollection[index].titleLabel?.text = game.type.buttonNames[index]
        }
    }
}
