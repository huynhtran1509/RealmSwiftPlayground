//: [Previous](@previous)

//: # Realms

import RealmSwift

//: Default `Realm` which lives in the Documents directory can be accessed with `Realm()`

let realm = try! Realm()

//: `Realm`s can be configured with custom locations or in memory stores

let inMemoryRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))

//: An instance of a realm should only be used on the thread it was created on

dispatch_async(dispatch_get_main_queue()) {
    //: Initialize a new `Realm` for each thread
    let backgroundRealm = try! Realm()
}

//: [Next](@next)
