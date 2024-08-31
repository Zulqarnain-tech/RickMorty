import Foundation
import Domain
import Networking



public struct CharacterDataRepository: CharacterListRepositoryProtocol {
   
    private let service: NetworkingService

    public init(service: NetworkingService) {
        self.service = service
    }

    public func getCharacterList(name: String?, species: String?, status: String?) async throws -> CharacterDataEntity {
        guard let request = GetCharacterListRequest(name: name, species: species, status: status).generateURLRequest()
        else {
            throw APIError.notFound
        }

        let dto: CharacterDataDTO = try await service.send(request)

        return dto.toCharacterListEntity()
    }
}
