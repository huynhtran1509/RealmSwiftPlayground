//: [Previous](@previous)

//: # Persisting Objects to a Realm
import RealmSwift

class Pokemon: Object {
    dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "PersistingObjects"))

let weedle = Pokemon(value: ["id": 13])
let caterpie = Pokemon(value: ["id": 10])

//: Realm uses write transactions
try! realm.write {
    realm.add([weedle, caterpie])
}

//: Write actions on an object that has been added to a realm will cause a crash outside of a write transaction.

// Uncomment me for a nice crash!
// caterpie.id = 15

//: Primary Keys can be used to update an object rather than create a duplicate
class Trainer: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    let pokemon = List<Pokemon>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

let misty = Trainer(value: ["id": 0, "name": "Misty"])

try! realm.write {
    realm.add(misty)
}

print("Misty has \(misty.pokemon.count) Pokemon")

try! realm.write {
    // Typlical use case of importing JSON from a server
    let json = ["name": "Misty", "id": 0, "pokemon": [ ["id": 10] ]]

    // Passing true for update will allow us to update existing records via primary key
    realm.create(Trainer.self, value: json, update: true)
}

//: Now our previously defined instance of Misty is up to date with no duplication!
print("Misty has \(misty.pokemon.count) Pokemon")


//: [Next](@next)
