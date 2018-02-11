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

enum Signal: String, Codable { // RawRepresentableに準拠
    case red
    case green
    case blue
}

// ルートがDictionary
let dictionaryJsonString = """
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

let dictionaryJsonData = dictionaryJsonString.data(using: .utf8)!
let dictionaryDecorded = try! JSONDecoder().decode(SomeStruct.self, from: dictionaryJsonData)
print(dictionaryDecorded)

// ルートがArray
let arrayJsonString = """
[
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
    },
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
]
"""

let arrayJsonData = arrayJsonString.data(using: .utf8)!
let arrayDecorded = try! JSONDecoder().decode([SomeStruct].self, from: arrayJsonData)
print(arrayDecorded)

