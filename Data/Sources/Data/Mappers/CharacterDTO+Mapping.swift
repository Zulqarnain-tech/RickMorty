import Foundation
import Domain
import Networking


extension CharacterDataDTO {
    
    func toCharacterListEntity() -> CharacterDataEntity {
        CharacterDataEntity(info: self.info.toInfoEntity(), results: self.results.map { $0.toResultEntity() })
    }
    
}

extension InfoDTO {
    func toInfoEntity() -> Info {
        return Info(count: self.count, pages: self.pages, next: self.next, prev: self.prev)
    }
}

extension ResultDTO {
    func toResultEntity() -> Result {
        
        return Result(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type,
            gender: self.gender,
            origin: self.origin.toLocationEntity(),
            location: self.location.toLocationEntity(),
            image: self.image,
            episode: self.episode,
            url: self.url,
            created: self.created
        )
    }
}


extension LocationDTO {
    func toLocationEntity() -> Location {
        return Location(name: self.name, url: self.url)
    }
}
