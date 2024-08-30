import XCTest
import Domain
import DomainMock

final class NasaPlanetsUseCaseTests: XCTestCase {
    func testWhenFetchAstronomiesSuccess_shouldReturnAstronomiesList() async  {
        let sut = MockCharactersListUseCase(charactersData: .mock)

        do {
            let characters = try await sut.getcharactersList(name: "", species: "", status: "")

            XCTAssertEqual(characters.results.count, 1)

            if let character = characters.results.first {
                XCTAssertEqual(character.name, "Rick Sanchez")
            } else {
                XCTFail("Astronomies array shouldn't be empty")
            }

        } catch {
            XCTFail("Fetching astronomies should return results")
        }
    }

    func testWhenFetchAstronomiesFailure_shouldReturnAstronomiesList() async  {
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
