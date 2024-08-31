import Foundation
import Dependencies
import Domain
import DomainMock
import Data
import Networking
import LocalPersistance
import LocalPersistanceMock



extension CharacterDataRepository: DependencyKey {
    public static var liveValue: any CharacterListRepositoryProtocol {
        CharacterDataRepository(
            service: NetworkingService()
        )
    }
}
enum CharacterDataUseCaseKey: TestDependencyKey {
    static var testValue: any CharactersListUseCaseProtocol {
        MockCharactersListUseCase()
    }

    static var previewValue: CharactersListUseCaseProtocol {
        MockCharactersListUseCase()
    }
}
extension CharacterDataUseCaseKey: DependencyKey {
    static var liveValue: any CharactersListUseCaseProtocol {
        CharactersListUseCase(
            repo: CharacterDataRepository.liveValue
        )
    }
}
extension DependencyValues {
    var characterDataUseCase: any CharactersListUseCaseProtocol {
        get { self[CharacterDataUseCaseKey.self] }
        set { self[CharacterDataUseCaseKey.self] = newValue }
    }
    
}

// MARK: -

/*
extension CoreDataService: DependencyKey {
    public static var liveValue: CoreDataService {
        CoreDataService()
    }
    
    
    public static var testValue: CoreDataService {
        return CoreDataService()
    }
}

extension DependencyValues {
    var coreDataService: CoreDataService {
        get { self[CoreDataService.self] }
        set { self[CoreDataService.self] = newValue }
    }
}
*/

enum LocalServiceKey: TestDependencyKey {
    static var testValue: any LocalServiceProtocol {
        MockCoreDataService()
    }

    static var previewValue: any LocalServiceProtocol {
        MockCoreDataService()
    }
}
extension LocalServiceKey: DependencyKey {
    static var liveValue: any LocalServiceProtocol {
        CoreDataService()
    }
}

extension DependencyValues {
    var localService: any LocalServiceProtocol {
        get { self[LocalServiceKey.self] }
        set { self[LocalServiceKey.self] = newValue }
    }
    
}
