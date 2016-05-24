//: [Previous](@previous)

//: # Threads

import RealmSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class Pokemon: Object {
    dynamic var name: String = ""
}

//: This `Realm` lives on the main thread
let realmIdentifier = "Threads"
let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: realmIdentifier))

let pokemon: Pokemon
try! realm.write {
    pokemon = realm.create(Pokemon.self, value: ["name": "Pikachu"])
}

//: And would crash if we access it or `Object`s created in it off the main thread
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
    
    // Uncomment me for a good time
    //    print("This pokemon's name is \(pokemon.name)")
    //    try! realm.write {
    //        pokemon.name = "Bulbasuar"
    //
    //        print("Now it's \(pokemon.name)")
    //    }
}

//: Create a new `Realm` for each thread and fetch `Object`s in the new `Realm`

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
    
    let backgroundRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: realmIdentifier))
    
    guard let pokemon = backgroundRealm.objects(Pokemon).filter("name = %@", "Pikachu").first else {
        return
    }
    
    print("This pokemon's name is \(pokemon.name)")
    
    try! backgroundRealm.write {
        pokemon.name = "Bulbasuar"
        
        print("Now it's \(pokemon.name)")
    }
}

/*:
 Changes can be monitored via
 - KVO on `Object`s
 - `Realm` notifications
 - Collection notifia
 */
