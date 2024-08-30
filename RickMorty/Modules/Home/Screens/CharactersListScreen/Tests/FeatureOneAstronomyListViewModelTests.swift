@testable import Rick_Morty
import XCTest
import Dependencies
import Domain
import DomainMock

final class FeatureOneAstronomyListViewModelTests: XCTestCase {
    func testWhenAstronomiesFetchedSuccesfully_shouldFillAstronomiesArray_andShowCorrectInfo() async {
        let sut = makeSUT(nasaPlanetsUseCase: MockNasaPlanetUseCase(astronomies: [.mock]))
        await sut.dispatch(.onAppear)

        XCTAssertEqual(sut.state.astronomies.count, 1)
        XCTAssertNil(sut.state.error)

        if let astronomy = sut.state.astronomies.first {
            XCTAssertEqual(astronomy.title, "Mock astronomy title")
        } else {
            XCTFail("Astronomy fetch should be succesful")
        }
    }

    func testWhenAstronomiesFetchError_shouldPresentError() async {
        let sut = makeSUT(
            nasaPlanetsUseCase: MockNasaPlanetUseCase(
                error: .general
            )
        )
        await sut.dispatch(.onAppear)

        XCTAssertEqual(sut.state.astronomies.count, 0)
        XCTAssertNotNil(sut.state.error)

        if let error = sut.state.error {
            XCTAssertEqual(error.message, "Oops, something went wrong")
        } else {
            XCTFail("Astronomy fetch should fail")
        }
    }

    // MARK: - Test helpers
    func makeSUT(
        nasaPlanetsUseCase: some NasaPlanetsUseCaseProtocol = MockNasaPlanetUseCase()
    ) -> CharacterListViewModel {
        let sut = withDependencies {
            $0.nasaPlanetsUseCase = nasaPlanetsUseCase
        } operation: {
            CharacterListViewModel(onAstronomySelected: {_ in})
        }

        return sut
    }
}
