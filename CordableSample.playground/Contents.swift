import Foundation

struct SomeStruct: Codable {
    let intValue: Int
    let stringValue: String
    let boolValue: Bool
    let arrayValue: [Int]
    let dictionaryValue: [String: String]
    let customValue: User
    let enumValue: Signal
    let optionalValue: Int?
    let nestedStruct: NestedStruct

    struct NestedStruct: Codable {
        let intValue: Int
        let stringValue: String
    }
}

struct User: Codable {
    let name: String
    var age: Int
}

enum Signal: String, Codable {
    case red
    case green
    case blue
}

let jsonString = """
{
    "intValue": 1000,
    "stringValue": "stringValue",
    "boolValue": true,
    "arrayValue": [1, 2, 3],
    "dictionaryValue": {"dictionaryKey": "dictionaryValue"},
    "customValue": {"name": "田中太郎", "age": 20},
    "enumValue": "green",
    "optionalValue": null,
    "nestedStruct": {"intValue": 2000, "stringValue": "hoge"}
}
"""

let jsonData = jsonString.data(using: .utf8)!
let someStruct = try! JSONDecoder().decode(SomeStruct.self, from: jsonData)
print(someStruct)
