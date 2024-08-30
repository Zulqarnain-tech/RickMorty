import Foundation


public struct CharacterDataEntity: Equatable, Codable {
    public let info: Info
    public let results: [Result]
    
    public init(info: Info, results: [Result]) {
        self.info = info
        self.results = results
    }
}

// MARK: - Info
public struct Info: Equatable, Codable {
    public let count, pages: Int
    public let next: String
    public let prev: String?
    
    public init(count: Int, pages: Int, next: String, prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

// MARK: - Result
public struct Result: Equatable, Codable {
    public let id: Int
    public let name, status, species, type: String
    public let gender: String
    public let origin, location: Location
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    
    public init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

// MARK: - Location
public struct Location: Equatable, Codable {
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
