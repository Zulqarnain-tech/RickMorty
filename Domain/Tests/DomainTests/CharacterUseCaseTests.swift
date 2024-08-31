import XCTest
import Domain
import DomainMock

final class NasaPlanetsUseCaseTests: XCTestCase {
    func testWhenFetchCharactersSuccess_shouldReturnCharactersList() async  {
        let sut = MockCharactersListUseCase(charactersData: .mock)

        do {
            let characters = try await sut.getcharactersList(name: "", species: "", status: "")

            XCTAssertEqual(characters.results.count, 1)

            if let character = characters.results.first {
                XCTAssertEqual(character.name, "Rick Sanchez")
            } else {
                XCTFail("Characters array shouldn't be empty")
            }

        } catch {
            XCTFail("Fetching Characters should return results")
        }
    }

    func testWhenFetchCharactersFailure_shouldReturnCharactersList() async  {
        let sut = MockCharactersListUseCase(error: .general)

        do {
            let _ = try await sut.getcharactersList(name: "", species: "", status: "")

        } catch let error {
            guard let concreteError = error as? CharacterListErrorEntity else {
                XCTFail("The error should be of CharacterDataErrorEntity type")
                return
            }
            XCTAssertEqual(concreteError, .general)
        }
    }
}
