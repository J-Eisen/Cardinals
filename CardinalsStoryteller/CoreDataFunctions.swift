//
//  CoreDataFunctions.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/29/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//

import UIKit
import CoreData

private let gameEntityString = "SavedGames"
private let gameEntityKeyPaths: [String] = ["gameName", "players.SavedCharacters[0].id", "players.SavedCharacters[1].id", "saveDate", "type", "id"]
private let characterEntityString = "SavedCharacters"
private let characterEntityKeyPaths: [String] = ["characterName", "portraitString", "color", "id"]
var saveDataCalled: Bool = false
var managedContextChanged: Bool = false

// MARK: - Saving Functions

func addCharacter(newCharacter: PlayerCharacter){
    guard let managedContext = getManagedContext() else { return }
    let entity = NSEntityDescription.entity(forEntityName: characterEntityString, in: managedContext)!
    let savedCharacter = NSManagedObject(entity: entity, insertInto: managedContext)
    savedCharacter.setValue(newCharacter.characterName, forKeyPath: "characterName")
    savedCharacter.setValue(newCharacter.portraitName, forKeyPath: "portraitString")
    savedCharacter.setValue(newCharacter.id, forKeyPath: "id")
    savedCharacter.setValue(newCharacter.color.rawValue, forKeyPath: "color")
    
    saveData()
}

func addGame(newGame: Game, player1: PlayerCharacter, player2: PlayerCharacter) {
    guard let managedContext = getManagedContext() else { return }
    let entity = NSEntityDescription.entity(forEntityName: gameEntityString, in: managedContext)!
    let savedGame = NSManagedObject(entity: entity, insertInto: managedContext)
    savedGame.setValue(newGame.gameName, forKeyPath: "gameName")
    savedGame.setValue(Date.init(), forKeyPath: "date")
    savedGame.mutableOrderedSetValue(forKey: "players").add(player1)
    savedGame.mutableOrderedSetValue(forKey: "players").add(player2)
    savedGame.setValue(newGame.type, forKey: "type")
    savedGame.setValue(newGame.id, forKey: "id")
    
    saveData()
}

func updateCharacter(characterToUpdate: PlayerCharacter){
    let fetchedCharacter = fetchData(entityString: characterEntityString, filter: characterToUpdate.id)?.last as! SavedCharacters
    fetchedCharacter.characterName = characterToUpdate.characterName
    fetchedCharacter.portraitString = characterToUpdate.portraitName
    fetchedCharacter.color = Int64(characterToUpdate.color.rawValue)
    fetchedCharacter.id = characterToUpdate.id
    
    if fetchedCharacter.games != nil {
        for gamePlaying in fetchedCharacter.games! {
            var found = false
            for gameName in characterToUpdate.gamesPlaying {
                if (gamePlaying as! SavedGames).gameName == gameName {
                    found = true
                }
            }
            if !found {
                fetchedCharacter.addToGames(gamePlaying as! SavedGames)
            }
        }
    }
    saveData()
}

func updateGame(gameToUpdate: Game) {
    let fetchedGame = fetchData(entityString: gameEntityString, filter: gameToUpdate.id)?.last as! SavedGames
    fetchedGame.gameName = gameToUpdate.gameName
    fetchedGame.saveDate = Date.init()
    fetchedGame.type = Int64(getType(typeName: gameToUpdate.type.typeName).rawValue)
    fetchedGame.id = gameToUpdate.id
    
    saveData()
}

//MARK: Converting from NSManagedObject to Object

func setUpNewCharacter(_ fetchedCharacter: NSManagedObject) -> PlayerCharacter {
    var gameIDs: [String] = []
    if let gamesPlaying = fetchedCharacter.value(forKeyPath: "games.SavedGames") as? [SavedGames] {
        for game in gamesPlaying {
            if game.id != nil {
                gameIDs.append(game.id!)
            }
        }
    }
    let newCharacter = PlayerCharacter.init(
        characterName: fetchedCharacter.value(forKeyPath: characterEntityKeyPaths[0]) as! String,
        portraitName: fetchedCharacter.value(forKeyPath: characterEntityKeyPaths[1]) as! String,
        gamesPlaying: gameIDs,
        characterColor: fetchedCharacter.value(forKeyPath: characterEntityKeyPaths[2]) as! Int,
        id: fetchedCharacter.value(forKeyPath: characterEntityKeyPaths[3]) as! String)
    return newCharacter
}

func setUpNewGame(_ fetchedGame: NSManagedObject) -> Game {
    let newGame = Game.init(
        gameName: fetchedGame.value(forKeyPath: gameEntityKeyPaths[0]) as! String,
        player1: fetchedGame.value(forKeyPath: gameEntityKeyPaths[1]) as! String,
        player2: fetchedGame.value(forKeyPath: gameEntityKeyPaths[2]) as! String,
        saveDate: fetchedGame.value(forKeyPath: gameEntityKeyPaths[3]) as! Date,
        type: fetchedGame.value(forKeyPath: gameEntityKeyPaths[4]) as! Int,
        id: fetchedGame.value(forKeyPath: gameEntityKeyPaths[5]) as! String)
    return newGame
}

// MARK: - Loading Functions

func loadCharacterArray() -> [PlayerCharacter]! {
    var loadedCharacterArray: [PlayerCharacter] = []
    
    if let fetchedCharacters = fetchData(entityString: characterEntityString, filter: nil) {
        if fetchedCharacters.count > 0 {
            for fetchedCharacter in fetchedCharacters {
                loadedCharacterArray.append(setUpNewCharacter(fetchedCharacter))
            }
        }
    }
    return loadedCharacterArray
}

func loadCharacter(playerID: String) -> PlayerCharacter! {
    guard let fetchedCharacter = fetchData(entityString: characterEntityString, filter: playerID)?.last else { return nil }
    return setUpNewCharacter(fetchedCharacter)
}

func loadGame(gameID: String) -> Game! {
    guard let fetchedGame = fetchData(entityString: gameEntityString, filter: gameID)?.last else { return nil }
    return setUpNewGame(fetchedGame)
}

func loadGameArray() -> [Game]! {
    var loadedGameArray: [Game] = []
    if let fetchedGames = fetchData(entityString: gameEntityString, filter: nil) {
        if fetchedGames.count > 0 {
            for fetchedGame in fetchedGames {
                loadedGameArray.append(setUpNewGame(fetchedGame))
            }
        }
    }
    return loadedGameArray
}

// MARK: - Helper Functions

// Fetch
func fetchData(entityString: String, filter: String!) -> [NSManagedObject]? {
    var fetchedData: [NSManagedObject] = []
    
    let managedContext = getManagedContext()
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityString)
    if filter != nil {
        fetchRequest.predicate = NSPredicate(format: "id == %@", filter)
    }
    do {
        fetchedData = try managedContext!.fetch(fetchRequest)
    } catch let error as NSError {
        print("Fetching Error. \(error), \(error.userInfo)")
    }
    return fetchedData
}

// Get Context

func getManagedContext() -> NSManagedObjectContext! {
    guard testMode == true else {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        else { return nil }
    let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let managedObjectContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = storeCoordinator
    return managedObjectContext
}

// Save Data

func saveData() {
    if testMode != true {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        appDelegate.saveContext()
    } else {
        guard let managedContext = getManagedContext() else {
                print ("Error creating mock context")
                return
        }
        managedContextChanged = managedContext.hasChanges
    }
}

