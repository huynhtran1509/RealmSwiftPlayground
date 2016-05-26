//: [Previous](@previous)
//: # Models
import RealmSwift

class Pokemon: Object {
    dynamic var height: Float = 0.0
    dynamic var id: Int = 0
    dynamic var type: String = ""
    dynamic var heldItem: String?
    var prettyDescription: String?
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    override static func ignoredProperties() -> [String] {
        return ["prettyDescription"]
    }
}

/*:
 Models inherit from `Object`

 - Supports indexing (faster queries slower inserts)
 - Supports `Bool`, `Int8`, `Int16`, `Int32`, `Int64`, `Double`, `Float`, `String`, `NSDate`, and `NSData`.
 - `String`, `NSDate`, and `NSData` can be `Optional`. `Object` properties *must* be optional.
 - Special `RealmOptional` class can be used for optional numeric types.
 - Can specify "ignored" properties that Realm won't manage
 - Subclassing is supported with a few catches.
 */

//: ## Creation
//: Models can be created by simply `init`ing them and setting properties
let pikachu = Pokemon()
pikachu.id = 25
pikachu.type = "Eletric"
pikachu.height = 1.04

//: Or with an object representing it's value
let weedle = Pokemon(value: ["id": 13, "height": 1.0, "type": "bug"])

//: [Next](@next)
