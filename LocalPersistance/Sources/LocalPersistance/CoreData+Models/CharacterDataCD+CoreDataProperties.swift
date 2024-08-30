//
//  CharacterDataCD+CoreDataProperties.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 30/08/2024.
//
//

import Foundation
import CoreData


extension CharacterDataCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterDataCD> {
        return NSFetchRequest<CharacterDataCD>(entityName: "CharacterDataCD")
    }

    @NSManaged public var toInfo: InfoCD?
    @NSManaged public var toResult: Set<ResultCD>?

}

// MARK: Generated accessors for toResult
extension CharacterDataCD {

    @objc(addToResultObject:)
    @NSManaged public func addToToResult(_ value: ResultCD)

    @objc(removeToResultObject:)
    @NSManaged public func removeFromToResult(_ value: ResultCD)

    @objc(addToResult:)
    @NSManaged public func addToToResult(_ values: NSSet)

    @objc(removeToResult:)
    @NSManaged public func removeFromToResult(_ values: NSSet)

}

extension CharacterDataCD : Identifiable {

}
