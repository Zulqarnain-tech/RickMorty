//
//  ResultCD+CoreDataProperties.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 30/08/2024.
//
//

import Foundation
import CoreData


extension ResultCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultCD> {
        return NSFetchRequest<ResultCD>(entityName: "ResultCD")
    }

    @NSManaged public var created: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var episode: [String]?
    @NSManaged public var location: LocationCD?
    @NSManaged public var origin: LocationCD?
    @NSManaged public var toCharacterData: CharacterDataCD?

}

// MARK: Generated accessors for episode
extension ResultCD {

    @objc(addEpisodeObject:)
    @NSManaged public func addToEpisode(_ value: ResultCD)

    @objc(removeEpisodeObject:)
    @NSManaged public func removeFromEpisode(_ value: ResultCD)

    @objc(addEpisode:)
    @NSManaged public func addToEpisode(_ values: NSSet)

    @objc(removeEpisode:)
    @NSManaged public func removeFromEpisode(_ values: NSSet)

}

extension ResultCD : Identifiable {

}
