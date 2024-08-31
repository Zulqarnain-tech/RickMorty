@testable import Rick_Morty
import XCTest
import Dependencies
import Domain
import DomainMock
import LocalPersistance
@testable import LocalPersistanceMock



final class CharacterListViewModelTests: XCTestCase {
    
    func testWhenCharacterDataFetchedSuccessfully_shouldFillCharacterList_andShowCorrectInfo() async {
        // Given
        debugPrint("testWhenCharacterDataFetchedSuccessfully_shouldFillCharacterList_andShowCorrectInfo")
        let mockCharacterData = CharacterDataEntity(
            info: Info(count: 1, pages: 1, next: "", prev: ""), 
            results: [
                Result(id: 1, name: "Rick", status: "Alive", species: "Human", type: "unknown", gender: "unknown", origin: Location(name: "unknown", url: "unknown"), location: Location(name: "Test Location", url: ""), image: "", episode: [], url: "", created: "")
            ]
        )
        let sut = makeSUT(coreDataService: MockCoreDataService(initialData: mockCharacterData),
                          characterDataUseCase: MockCharactersListUseCase(charactersData: mockCharacterData))
        
        // When
        await sut.dispatch(.onAppear)
        
        // Then
        XCTAssertEqual(sut.state.originalCharacterList.count, 1)
        XCTAssertNil(sut.state.error)
        
        if let character = sut.state.originalCharacterList.first {
            XCTAssertEqual(character.location.name, "Test Location")
        } else {
            XCTFail("Character data fetch should be successful")
        }
    }
    
    func testWhenCharacterDataFetchError_shouldPresentError() async {
        // Given
        let sut = makeSUT(
            coreDataService: MockCoreDataService(),
            characterDataUseCase: MockCharactersListUseCase(error: .general)
        )
        
        // When
        await sut.dispatch(.onAppear)
        
        // Then
        XCTAssertEqual(sut.state.originalCharacterList.count, 0)
        XCTAssertNotNil(sut.state.error)
        
        if let error = sut.state.error {
            XCTAssertEqual(error.message, "Oops, something went wrong")
        } else {
            XCTFail("Character data fetch should fail")
        }
    }
    
    func testFilterByLocation_whenSelectedKnownIsCharity_shouldFilterCorrectly() {
        // Given
        let characterData = CharacterDataEntity(
            info: Info(count: 2, pages: 1, next: "", prev: nil),
            results: [
                Result(
                    id: 1, name: "Character1", status: "Alive", species: "Human", type: "",
                    gender: "Male", origin: Location(name: "Origin1", url: ""), location: Location(name: "Charity", url: ""),
                    image: "image1.png", episode: ["https://rickandmortyapi.com/api/episode/1"], url: "", created: ""
                ),
                Result(
                    id: 2, name: "Character2", status: "Dead", species: "Alien", type: "",
                    gender: "Female", origin: Location(name: "Origin2", url: ""), location: Location(name: "Other", url: ""),
                    image: "image2.png", episode: ["https://rickandmortyapi.com/api/episode/2"], url: "", created: ""
                )
            ]
        )

        let sut = makeSUT(coreDataService: MockCoreDataService(initialData: characterData),
                          characterDataUseCase: MockCharactersListUseCase(charactersData: characterData))
        
        sut.state.originalCharacterList = characterData.results
        sut.charactersList = characterData.results
        
        // When
        sut.selectedKnown = "Charity"
        
        // Then
        XCTAssertEqual(sut.charactersList.count, 1)
        XCTAssertEqual(sut.charactersList.first?.location.name, "Charity")
    }
    
    func testResetFilters_whenSelectedKnownIsAll_shouldResetFilters() {
        // Given
        let characterData = CharacterDataEntity(
            info: Info(count: 2, pages: 1, next: "", prev: nil),
            results: [
                Result(
                    id: 1, name: "Character1", status: "Alive", species: "Human", type: "",
                    gender: "Male", origin: Location(name: "Origin1", url: ""), location: Location(name: "Charity", url: ""),
                    image: "image1.png", episode: ["https://rickandmortyapi.com/api/episode/1"], url: "", created: ""
                ),
                Result(
                    id: 2, name: "Character2", status: "Dead", species: "Alien", type: "",
                    gender: "Female", origin: Location(name: "Origin2", url: ""), location: Location(name: "Other", url: ""),
                    image: "image2.png", episode: ["https://rickandmortyapi.com/api/episode/2"], url: "", created: ""
                )
            ]
        )

        let sut = makeSUT(coreDataService: MockCoreDataService(initialData: characterData),
                          characterDataUseCase: MockCharactersListUseCase(charactersData: characterData))
        
        sut.state.originalCharacterList = characterData.results
        sut.charactersList = characterData.results
        sut.selectedKnown = "Charity"
        
        // When
        sut.selectedKnown = "All"
        
        // Then
        XCTAssertEqual(sut.charactersList.count, 2)
        XCTAssertTrue(sut.charactersList.contains { $0.location.name == "Charity" })
        XCTAssertTrue(sut.charactersList.contains { $0.location.name == "Other" })
    }
    
    func testErrorHandling_whenFetchCharacterDataFails_shouldHandleError() async {
        // Given
        let sut = makeSUT(
            coreDataService: MockCoreDataService(),
            characterDataUseCase: MockCharactersListUseCase(error: .general)
        )
        
        // When
        await sut.fetchCharacterData(searchedQuery: false)
        
        // Then
        XCTAssertEqual(sut.state.originalCharacterList.count, 0)
        XCTAssertNotNil(sut.state.error)
        
        if let error = sut.state.error {
            XCTAssertEqual(error.message, "Oops, something went wrong")
        } else {
            XCTFail("Error should be handled")
        }
    }
    
    // MARK: - Test Helpers
    func makeSUT(
        coreDataService: some LocalServiceProtocol = MockCoreDataService(),
        characterDataUseCase: some CharactersListUseCaseProtocol = MockCharactersListUseCase()
    ) -> CharacterListViewModel {
        let sut = withDependencies {
            $0.coreDataService = coreDataService as! CoreDataService
            $0.characterDataUseCase = characterDataUseCase
        } operation: {
            CharacterListViewModel(onCharacterSelected: {_ in})
        }
        debugPrint("-testPrint returning from makeSUT")
        return sut
    }
}

