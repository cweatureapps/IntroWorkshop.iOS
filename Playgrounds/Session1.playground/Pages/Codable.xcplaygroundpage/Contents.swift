//: [Previous](@previous)

import Foundation

/*:
 A big part of our job as iOS engineers is to process JSON messages coming from the backend, and then represent this in a UI.

 JSON serialization and deserialization has traditionally been performed manually on iOS,
 but Swift now supports this directly through the `Codable` protocol.
 Adopting Codable on your own types enables you to serialize them to and from any of the built-in data formats.
 */

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate

    // Landmark is still codable after adding these properties.
    var vantagePoints: [Coordinate]
    var metadata: [String: String]
    var website: URL?
}


/*:
 For more details on customizing the behaviour, see the Apple documentation for
 [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
 */

//: [Next](@next)
