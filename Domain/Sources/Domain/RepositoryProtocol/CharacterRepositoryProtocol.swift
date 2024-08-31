import Foundation


public protocol CharacterListRepositoryProtocol {
    func getCharacterList(name: String?, species: String?, status: String?) async throws -> CharacterDataEntity
}
