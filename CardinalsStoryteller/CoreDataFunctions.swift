//
//  CoreDataFunctions.swift
//  CardinalsStoryteller
//
//  Created by Jonah Eisenstock on 3/29/19.
//  Copyright © 2019 Jonah Eisenstock. All rights reserved.
//
/*
import UIKit
import CoreData

let gameEntityString = "SavedGames"
let characterEntityString = "SavedCharacters"
var saveDataCalled: Bool = false
var managedContextChanged: Bool = false

func addCharacter(newCharacter: PlayerCharacter){
    guard let managedContext = getManagedContext() else { return }
    let entity = NSEntityDescription.entity(forEntityName: characterEntityString, in: managedContext)!
    let savedCharacter = NSManagedObject(entity: entity, insertInto: managedContext)
    savedCharacter.setValue(newCharacter.characterName, forKeyPath: "characterName")
    savedCharacter.setValue(newCharacter.portraitName, forKeyPath: "portraitName")
    savedCharacter.setValue(newCharacter.id, forKey: "id")
    
    saveData()
}

func addGame(newGame: Game, player1: PlayerCharacter, player2: PlayerCharacter) {
    guard let managedContext = getManagedContext() else { return }
    let entity = NSEntityDescription.entity(forEntityName: gameEntityString, in: managedContext)!
    let savedGame = NSManagedObject(entity: entity, insertInto: managedContext)
    savedGame.setValue(newGame.gameName, forKeyPath: "gameName")
    savedGame.setValue(Date.init(), forKeyPath: "date")
    savedGame.setValue(player1, forKeyPath: "players.source")
    savedGame.setValue(player2, forKeyPath: "players.source")
//    let savedPlayers = loadCharacter()
//    savedPlayer1.setValue(game, forKeyPath: "games.source")
//    let savedPlayer1 = loadCharacter()
//    savedPlayer1.setValue(game, forKeyPath: "games.source")
    
    saveData()
}

func updateCharacter(updatedCharacter: PlayerCharacter){
    let fetchedCharacter = fetchData(entityString: characterEntityString, filter: updatedCharacter.characterName, filterType: "characterName")?.last
    fetchedCharacter?.setValue(updatedCharacter.characterName, forKey: "characterName")
    fetchedCharacter?.setValue(updatedCharacter.portraitName, forKey: "portraitName")
    saveData()
}

func updateGame(updatedGame: Game) {
    let fetchedGame = fetchData(entityString: gameEntityString, filter: updatedGame.gameName, filterType: "gameName")?.last
    fetchedGame?.setValue(updatedGame.gameName, forKey: "gameName")
    fetchedGame?.setValue(Date.init(), forKey: "saveDate")
//    fetchedGame?.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
    saveData()
}

func loadCharacterArray() -> [PlayerCharacter]! {
    var loadedCharacterArray: [PlayerCharacter] = []
    
    if let fetchedCharacters = fetchData(entityString: characterEntityString, filter: nil, filterType: nil) {
        if fetchedCharacters.count > 0 {
            for fetchedCharacter in fetchedCharacters {
                let newCharacter = PlayerCharacter.init(
                    characterName: fetchedCharacter.value(forKey: "characterName") as? String ?? "Default",
                    portraitName: fetchedCharacter.value(forKey: "portraitName") as? String ?? "Default")
                loadedCharacterArray.append(newCharacter)
            }
        }
    }
    return loadedCharacterArray
}

func loadCharacter(playerToLoad: PlayerCharacter) -> PlayerCharacter! {
    guard let fetchedCharacter = fetchData(entityString: characterEntityString, filter: playerToLoad.characterName, filterType: "characterName")?.last else { return nil }
    let loadedCharacter = PlayerCharacter.init(
        characterName: fetchedCharacter.value(forKey: "characterName") as! String,
        portraitName: fetchedCharacter.value(forKey: "portraitName") as! String)
    return loadedCharacter
}

func loadGame(gameToLoad: Game) -> Game! {
    guard let fetchedGame = fetchData(entityString: gameEntityString, filter: gameToLoad.gameName, filterType: "gameName")?.last else { return nil }
    let loadedGame = Game.init(
        saveDate: fetchedGame.value(forKey: "saveDate") as! Date,
        gameName: fetchedGame.value(forKey: "gameName") as! String)
    return loadedGame
}

func loadGameArray() -> [Game]! {
    var loadedGameArray: [Game] = []
    
    if let fetchedGames = fetchData(entityString: gameEntityString, filter: nil) {
        if fetchedGames.count > 0 {
            for fetchedGame in fetchedGames {
                let newGame = Game.init(
                    gameName: fetchedGame.value(forKeyPath: "gameName") as! String,
                    player1: fetchedGame.value(forKeyPath: "players.source") as! PlayerCharacter,
                    player2: <#T##String#>,
                    saveDate: fetchedGame.value(forKeyPath: "saveDate") as! Date,
                    id: fetchedGame.value(forKey: "id") as! String)
                loadedGameArray.append(newGame)
            }
        }
    }
    return loadedGameArray
}

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
*/
