import Foundation
import CoreData
import Domain


public protocol BaseService {

    associatedtype T

    func create(record: T)
    func fetch() -> T?
}
public protocol LocalServiceProtocol : BaseService {
    
    func create(record: CharacterDataEntity)
    func fetch() -> CharacterDataEntity?
}



public struct CoreDataService: LocalServiceProtocol {
    
    public typealias T = CharacterDataEntity

    public init(){
        
    }
    public func create(record: CharacterDataEntity) {
        let cdCharacterDataObject = CharacterDataCD(context: PersistentStorage.shared.context)
        
        let cdInfo = InfoCD(context: PersistentStorage.shared.context)
        cdInfo.count = Int32(record.info.count)
        cdInfo.next = record.info.next
        cdInfo.pages = Int32(record.info.pages)
        cdInfo.prev = record.info.prev
        cdCharacterDataObject.toInfo = cdInfo
        
        if !record.results.isEmpty {
            var resultCDArray = Set<ResultCD>()
            
            for result in record.results {
                let cdResult = ResultCD(context: PersistentStorage.shared.context)
                cdResult.id = Int32(result.id)
                cdResult.name = result.name
                cdResult.status = result.status
                cdResult.species = result.species
                cdResult.type = result.type
                cdResult.gender = result.gender
                cdResult.image = result.image
                cdResult.url = result.url
                cdResult.created = result.created
                cdResult.episode = result.episode
                
                // Handle origin and location
                let cdOrigin = LocationCD(context: PersistentStorage.shared.context)
                cdOrigin.name = result.origin.name
                cdOrigin.url = result.origin.url
                cdResult.origin = cdOrigin
                
                let cdLocation = LocationCD(context: PersistentStorage.shared.context)
                cdLocation.name = result.location.name
                cdLocation.url = result.location.url
                cdResult.location = cdLocation
                
                // Set the relationship back to CharacterDataCD
                cdResult.toCharacterData = cdCharacterDataObject
                
                // Append to the resultCDArray
                resultCDArray.insert(cdResult)
            }
            
            // Convert the array to NSSet and assign it to toResult
            cdCharacterDataObject.toResult =  resultCDArray
        }
        
        debugPrint("call PersistentStorage.shared.saveContext()")
        PersistentStorage.shared.saveContext()
    }


    public func fetch() -> CharacterDataEntity? {
        // Create a fetch request for CharacterDataCD
        let fetchRequest: NSFetchRequest<CharacterDataCD> = CharacterDataCD.fetchRequest()

        do {
            // Fetch the results from Core Data
            if let cdCharacterData = try PersistentStorage.shared.context.fetch(fetchRequest).first {
                
                // Convert InfoCD to Info
                let info = Info(count: Int(cdCharacterData.toInfo?.count ?? 0),
                                pages: Int(cdCharacterData.toInfo?.pages ?? 0),
                                next: cdCharacterData.toInfo?.next ?? "",
                                prev: cdCharacterData.toInfo?.prev)
                
                // Convert ResultCD array to Result array
                var results: [Result] = []
                if let cdResults = cdCharacterData.toResult {
                    for cdResult in cdResults {
                        let result = Result(
                            id: Int(cdResult.id),
                            name: cdResult.name ?? "",
                            status: cdResult.status ?? "",
                            species: cdResult.species ?? "",
                            type: cdResult.type ?? "",
                            gender: cdResult.gender ?? "",
                            origin: Location(name: cdResult.origin?.name ?? "", url: cdResult.origin?.url ?? ""),
                            location: Location(name: cdResult.location?.name ?? "", url: cdResult.location?.url ?? ""),
                            image: cdResult.image ?? "",
                            episode: cdResult.episode ?? [],
                            url: cdResult.url ?? "",
                            created: cdResult.created ?? ""
                        )
                        results.append(result)
                    }
                }

                // Return the CharacterDataEntity with the converted data
                return CharacterDataEntity(info: info, results: results)
            }
        } catch {
            print("Failed to fetch character data: \(error)")
        }

        return nil
    }

 }


 
