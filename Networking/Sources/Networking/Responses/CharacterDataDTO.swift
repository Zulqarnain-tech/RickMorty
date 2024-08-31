import Foundation




public struct CharacterDataDTO: Equatable, Codable {
    public let info: InfoDTO
    public let results: [ResultDTO]
    
    public init(info: InfoDTO, results: [ResultDTO]) {
        self.info = info
        self.results = results
    }
}

// MARK: - Info
public struct InfoDTO: Equatable, Codable {
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
public struct ResultDTO: Equatable, Codable {
    public let id: Int
    public let name, status, species, type: String
    public let gender: String
    public let origin, location: LocationDTO
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    
    public init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: LocationDTO, location: LocationDTO, image: String, episode: [String], url: String, created: String) {
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
public struct LocationDTO: Equatable, Codable {
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
