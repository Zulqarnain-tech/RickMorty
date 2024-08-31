import Domain


public final class MockCharactersListUseCase: CharactersListUseCaseProtocol {
    
    
    let charactersData: CharacterDataEntity
    let error: CharacterListErrorEntity?

    public init(
        charactersData: CharacterDataEntity = CharacterDataEntity(info: Info(count: 0, pages: 0, next: "", prev: ""), results: []),
        error: CharacterListErrorEntity? = nil
    ) {
        self.charactersData = charactersData
        self.error = error
    }
    
    public func getcharactersList(name: String?, species: String?, status: String?) async throws -> CharacterDataEntity {
        guard let error else {
            return charactersData
        }

        throw error
    }
}
