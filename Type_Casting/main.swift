//
//  main.swift
//  Type_Casting
//
//  Created by M_2022814 on 12/14/21.
//

import Foundation

// MARK: - Type Casting
// Type Casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.
// Type casting in Swift is implemented with the is and as operators. THey are used to check the tyoe of a value or casr a value to a different tyoe.
// You can also use type casting to check whether a type conforms to a protocol.


// Base Class
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

// The subclasses of MediaItem Base Class
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// The final array creates a constant array which contains instances of the songs and movies.
// The type of the library array is inferred by initializing it with the contents of an array literal.

let library = [

    Movie(name: "Evil Dead" , director: "Savage Pain" ),
    Song(name: "Helpless", artist: "Heartless"),
    Movie(name: "Summer", director: "Sadness"),
    Song(name: "Dreamtime", artist: "Dragon"),
    Movie(name: "Fearsome", director: "Flower")
] // The type of "library" is inferred to be [MediaItem]

// The items stored in library are stille Movie and Song instances behind the scenes.
// However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem, not as Movie or Song.

// In order to work with them as their native type, you need to check their type, or downcast them to a different type

// MARK: - Checking Type
// Use the type check operator(is) to check whether an instance is of a certain subclass type.
// The type check operator returns true if the instance is of that subclass and false if it is not

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie{
        movieCount += 1
    } else if item is Song{
        songCount += 1
    }
}

print("The media library contains \(movieCount) movies and \(songCount) songs")

// MARK: - Downcasting
// A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes.
// When you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!)

// Because downcasting can fail, the type cast operator comes in two different forms:
    // as? returns an optional value of the type you are trying to downcast to
        // Use this when you aren't sure a downcast will succeed. Then you can do error handling
    // as! attempts to downcast and force unwraps the result in a single compound action
        // Only use if you are sure downcast will succeed. If not, it will cause a runtime error if you try to downcast to an incorrect class type

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), directed by: \(movie.director)")
    }else if let song = item as? Song {
        print("Song: \(song.name), directed by: \(song.artist)")
    }
}

// MARK: - Type Casting for Any and AnyObject
// Swift provides two special types for working with nonspecific types:
// Any can represent an instance of any type at all, including function types.
// AnyObject can represent an instance of any class type.
// Use these keywords only when you explicitly need this behavior. It;s always better to be specific about types you expect to work with in your code.

var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Dream Theater", director: "Heartless Rose"))
things.append({(name: String) -> String in "Hello \(name)"})

// To determine the type, use the is and as pattern

for thing in things {
    switch thing {
    case 0 as Int:
        print("Zero as an Int")
    case 0 as Double:
        print("Zero as a Double")
    case let someInt as Int:
        print("\(someInt) is an Integer")
    case let someDouble as Double where someDouble > 0:
        print("\(someDouble) is a positive Double")
    case is Double:
        print("Some other double ")
    case let someString as String:
        print("\(someString) is a String")
    case let (x, y) as (Double, Double):
        print("An (x,y) point at (\(x),\(y)")
    case let movie as Movie:
        print("A movie called \(movie.name)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Micharl"))
    default:
        print("Type can't be identified")
        
        
    }
}
