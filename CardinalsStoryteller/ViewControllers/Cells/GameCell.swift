//
//  GameCell.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/30/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var portrait1: UIImageView!
    @IBOutlet weak var portrait2: UIImageView!
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
