// Cordableのサンプル
// 参考: https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

import Foundation

// Json文字列を指定した型のインスタンスにデコードする
extension String {
    func decordJson<T: Codable>(to type: T.Type) -> T {
        let jsonData = self.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: jsonData)
    }
}

// 基本型（Int, Double, String, Bool, Date, Data, URL）
struct BasicType: Codable {
    let intValue: Int
    let doubleValue: Double
    let stringValue: String
    let boolValue: Bool
    let dateValue: Date
    let dataValue: Data
    let urlValue: URL
}

let basicTypeJson = """
{
"intValue": 1,
"doubleValue": 1.5,
"stringValue": "文字列",
"boolValue": true,
"dateValue": 1518416857.41261,
"dataValue": "QmFzZTY044Ko44Oz44Kz44O844OJ44GX44Gf5paH5a2X5YiX",
"urlValue": "http://swiftdoc.org/",
}
"""

print(basicTypeJson.decordJson(to: BasicType.self))

// ArrayとDictionary
struct StructureType: Codable {
    let arrayValue: [Int]
    let dictionaryValue: [String: String]
}

let structureTypeJson = """
{
"arrayValue": [1, 2, 3],
"dictionaryValue": {"dictionaryKey": "dictionaryValue"}
}
"""
print(structureTypeJson.decordJson(to: StructureType.self))

// カスタム型
struct CustomType: Codable {
    let user: User
}

struct User: Codable {
    let name: String
    var age: Int
}

let customTypeJson = """
{
"user": {"name": "Taro", "age": 20}
}
"""

print(customTypeJson.decordJson(to: CustomType.self))

// enum型
struct EnumType: Codable {
    let signal: Signal
}

enum Signal: String, Codable { // RawRepresentableに準拠
    case red
    case green
    case blue
}

let enumTypeJson = """
{
"signal": "green"
}
"""

print(enumTypeJson.decordJson(to: EnumType.self))

// Optional型
struct OptionalType: Codable {
    let optionalValue: Int?
}

let optionalTypeJson = """
{
"optionalType": null
}
"""

print(optionalTypeJson.decordJson(to: OptionalType.self))

// ネスト型
struct NestedType: Codable {
    let child: Child
    struct Child: Codable {
        let id: Int
    }
}

let nestedTypeJson = """
{
"child": {"id": 100}
}
"""

print(nestedTypeJson.decordJson(to: NestedType.self))

// ルートがArrayの場合

struct Book: Codable {
    let name: String
    let price: Int
}

let bookListJsonString = """
[{"name": "タイトル1", "price": 1500},
{"name": "タイトル2", "price": 1200}]
"""

print(bookListJsonString.decordJson(to: [Book].self))

// JSONのキーとプロパティ名が異なる場合
struct Person: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    
    // CodingKeyプロトコルに準拠したCodingKeysという名前の列挙体を定義する
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

let personJsonString = """
{
"id": 1,
"first_name": "Taro",
"last_name": "Tanaka"
}
"""
print(personJsonString.decordJson(to: Person.self))

print(Date().timeIntervalSince1970)





