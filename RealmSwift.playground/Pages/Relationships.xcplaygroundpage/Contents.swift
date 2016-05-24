//: [Previous](@previous)

//: # Relationships

import RealmSwift

class Pokemon: Object {
    dynamic var id: Int = 0
    dynamic var heldItem: Item?
    let owner = LinkingObjects(fromType: Trainer.self, property: "pokemon")
}

class Item: Object {
    dynamic var name: String = ""
}

class Trainer: Object {
    dynamic var name: String = ""
    let pokemon = List<Pokemon>()
}

//: Realm supports To-One relationships

let pikachu = Pokemon(value: ["id": 25])
let item = Item(value: ["name": "Magnet"])

pikachu.heldItem = item

print("Pikachu is holding a \(pikachu.heldItem!.name)")

//: And To-Many relationships

let trainer = Trainer(value: ["name": "Ash"])

let weedle = Pokemon(value: ["id": 13])
let caterpie = Pokemon(value: ["id": 10])

trainer.pokemon.appendContentsOf([weedle, caterpie])

//: Inverse relationships use the `LinkingObjects` class

print("Weedle's owner is \(weedle.owner.first)")

//: So why is `weedle.owner.first` nil? We need to add our objects to a `Realm`
//: to trigger some behaviour.


//: [Next](@next)
