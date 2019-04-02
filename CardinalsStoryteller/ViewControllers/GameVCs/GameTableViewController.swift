//
//  GameTableViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//
/*
import UIKit

private let reuseIdentifier = ""

class GameTableViewController: UIViewController {
//    var gameArray = loadGameArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GameCell
        let gameData = gameArray![indexPath.item]
        cell.dateLabel.text = gameData.saveDate.description
        cell.gameNameLabel.text = gameData.gameName
        return cell
    }
    
    
}

extension GameTableViewController: UITableViewDelegate {
    
}
*/
