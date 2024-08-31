import XCTest
import LocalPersistanceMock
import Domain
@testable import LocalPersistance
//@testable import LocalPersistanceMock


 final class LocalPersistenceTests: XCTestCase {

     // Define a sample CharacterDataEntity for testing
     private func createTestCharacterDataEntity() -> CharacterDataEntity {
         let info = Info(count: 10, pages: 1, next: "nextPage", prev: "prevPage")
         let result = Result(
             id: 1,
             name: "Test Character",
             status: "Alive",
             species: "Human",
             type: "Type",
             gender: "Male",
             origin: Location(name: "Earth", url: "earthUrl"),
             location: Location(name: "Citadel", url: "citadelUrl"),
             image: "imageUrl",
             episode: ["episodeUrl"],
             url: "characterUrl",
             created: "2024-08-31"
         )
         return CharacterDataEntity(info: info, results: [result])
     }

     func testCreateAndFetch() throws {
         // Arrange
         let initialData = createTestCharacterDataEntity()
         let mockService = MockCoreDataService(initialData: initialData)
         
         // Act
         let fetchedData = mockService.fetch()
         
         // Assert
         XCTAssertNotNil(fetchedData, "Fetched data should not be nil")
         XCTAssertEqual(fetchedData?.info.count, 10, "Info count should be 10")
         XCTAssertEqual(fetchedData?.results.first?.name, "Test Character", "Character name should be 'Test Character'")
     }

     func testCreateUpdatesData() throws {
         // Arrange
         let initialData = createTestCharacterDataEntity()
         let updatedData = CharacterDataEntity(info: Info(count: 20, pages: 2, next: "https://rickandmortyapi.com/api/character/?page=2", prev: ""), results: [])
         let mockService = MockCoreDataService(initialData: initialData)
         
         // Act
         mockService.create(record: updatedData)
         let fetchedData = mockService.fetch()
         
         // Assert
         XCTAssertNotNil(fetchedData, "Fetched data should not be nil")
         XCTAssertEqual(fetchedData?.info.count, 20, "Info count should be 20")
         XCTAssertTrue(fetchedData?.results.isEmpty ?? false, "Results should be empty")
     }
     
     func testCreateWithNilData() throws {
         // Arrange
         let mockService = MockCoreDataService(initialData: nil)
         let newData = createTestCharacterDataEntity()
         
         // Act
         mockService.create(record: newData)
         let fetchedData = mockService.fetch()
         
         // Assert
         XCTAssertNotNil(fetchedData, "Fetched data should not be nil")
         XCTAssertEqual(fetchedData?.info.count, 10, "Info count should be 10")
     }
     
     // Additional test cases can be added as needed
 }
 
