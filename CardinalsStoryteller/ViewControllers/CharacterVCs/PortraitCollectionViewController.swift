//
//  PortraitCollectionViewController.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/16/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PortraitCell"
private let saveSegueIdentifier = "ReturnToNewCharacterSave"
private let cancelSegueIdentifier = "ReturnToNewCharacterCancel"

class PortraitCollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedImageName: String!
    var selectedCellNumber: Int!
    var imageNameArray: [String] = []
    let largeSize: CGFloat = 128
    let smallSize: CGFloat = 112
    var tempCharacterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageNameArray = setUpImageNameArray()
        // Register cell classes
        collectionView.layoutIfNeeded()
        collectionView!.register(PortraitCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewCharacterViewController {
            let vc = segue.destination as! NewCharacterViewController
            vc.characterName = tempCharacterName
            if segue.identifier == saveSegueIdentifier {
                vc.imageName = imageNameArray[selectedCellNumber]
            } else if segue.identifier == cancelSegueIdentifier {
                vc.imageName = selectedImageName
            }
        }
    }
}
    // MARK: UICollectionViewDataSource
extension PortraitCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PortraitCell
        guard indexPath.item < imageNameArray.count else { return cell }
        cell.portraitImage.image = UIImage.init(named: imageNameArray[indexPath.item])
        if indexPath.item == selectedCellNumber {
            cell.backgroundColor = .blue
            cell.bounds.size.width = largeSize
            cell.bounds.size.height = largeSize
        } else {
            cell.bounds.size.width = smallSize
            cell.bounds.size.height = smallSize
            cell.backgroundColor = nil
        }
        return cell
    }
}

extension PortraitCollectionViewController: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Select Item
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PortraitCell
        if selectedCellNumber != nil {
            var lastIndexPath = indexPath
            lastIndexPath.item = selectedCellNumber
            let lastCell = collectionView.cellForItem(at: lastIndexPath) as! PortraitCell
            lastCell.bounds.size.width = smallSize
            lastCell.bounds.size.height = smallSize
        }
        selectedCell.bounds.size.width = largeSize
        selectedCell.bounds.size.height = largeSize
        selectedCellNumber = indexPath.item
        return true
    }
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

func setUpImageNameArray() -> [String] {
    var array: [String] = []
    for i in 1...maxF {
        array.append("F_\(i)")
    }
    for i in 1...maxM{
        array.append("M_\(i)")
    }
    array.append(contentsOf: unknownPortraitArray)
    return array
}
