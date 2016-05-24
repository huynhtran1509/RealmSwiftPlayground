//: [Previous](@previous)

//: # Queries

import RealmSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "Queries"))

//: Let's add some test data
class Trainer: Object {
    dynamic var name: String = ""
    let pokemon = List<Pokemon>()
}

class Pokemon: Object {
    dynamic var name: String = ""
    dynamic var type: String = ""
    let owner = LinkingObjects(fromType: Trainer.self, property: "pokemon")
}

try! realm.write {
    let ash = Trainer(value: ["name": "Ash"])
    let misty = Trainer(value: ["name": "Misty"])
    
    let pikachu = Pokemon(value: ["name": "Pikachu", "type": "Electric"])
    let weedle = Pokemon(value: ["name": "Weedle", "type": "Bug"])
    let squirtle = Pokemon(value: ["name": "Squirtle", "type": "Water"])
    let vulpix = Pokemon(value: ["name": "Vulpix", "type": "Fire"])
    
    ash.pokemon.appendContentsOf([pikachu, weedle])
    misty.pokemon.appendContentsOf([squirtle, vulpix])
    
    realm.add([ash, misty])
}

//: Your new best friend is the `Results` class
let allPokemon = realm.objects(Pokemon)

//: `Results` are lazy- execution is deffered until data is accessed
print("There are \(allPokemon.count) pokemon")

//: `Results` are auto updating
try! realm.write {
    realm.create(Pokemon.self, value: ["name": "Charmander", "type": "Fire"])
}

print("There are now \(allPokemon.count) pokemon")

//: `Results` can be filtered
let firePokemon = realm.objects(Pokemon).filter("type = %@", "Fire")
print("There are \(firePokemon.count) Fire type pokemon")

//: `Results` can be chained
let mistysFirePokemon = firePokemon.filter("ANY owner.name = %@", "Misty")
print("Misty has \(mistysFirePokemon.count) Fire type pokemon")

//: `Results` can be sorted
let pokemonByName = allPokemon.sorted("name")
print(pokemonByName)

//: `Results` can be observed
let token = allPokemon.addNotificationBlock { change in
   
    switch change {
    case .Initial:
        print("allPokemon is now populated")
        
    case .Update(let results, let deletions, let insertions, let modifications):
        print("allPokemon updated with \(deletions.count) deletions, \(insertions.count) insertions, and \(modifications.count) modifications")
        break
        
    case .Error:
        print("Oh no!")
    }
    
}

try! realm.write {
    realm.delete(realm.objects(Pokemon).filter("type = %@", "Fire"))
    realm.create(Pokemon.self, value: ["name": "Geodude", "type": "Rock"])
}

//: You would usually stop observing using your token in deinit or when you're done observing
// token.stop()

//: [Next](@next)
