import Foundation


public struct GetCharacterListRequest: GetAPIRequest {
    public typealias ResponseType = [CharacterDataDTO]

    let name: String?
    let species: String?
    let status: String?
    
    public init (name: String?, species: String?, status: String?) {
        self.name = name
        self.species = species
        self.status = status
    }

    public var endpoint: String {
        "/character"
    }
    public var queryItems: [URLQueryItem] {
       
        return [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "species", value: species),
            URLQueryItem(name: "status", value: status)
        ]

    }
}
