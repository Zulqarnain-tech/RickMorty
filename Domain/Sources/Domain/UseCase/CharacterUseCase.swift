import Foundation


public protocol CharactersListUseCaseProtocol {
    func getcharactersList(name: String?, species: String?, status: String?) async throws -> CharacterDataEntity
}

public struct CharactersListUseCase: CharactersListUseCaseProtocol {
    private let repo: any CharacterListRepositoryProtocol

    public init(repo: any CharacterListRepositoryProtocol) {
        self.repo = repo
    }

    public func getcharactersList(name: String?, species: String?, status: String?) async throws -> CharacterDataEntity {
        try await repo.getCharacterList(name: name, species: species, status: status)
    }
}
