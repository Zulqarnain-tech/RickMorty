//
//  InfoCD+CoreDataProperties.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 30/08/2024.
//
//

import Foundation
import CoreData


extension InfoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InfoCD> {
        return NSFetchRequest<InfoCD>(entityName: "InfoCD")
    }

    @NSManaged public var count: Int32
    @NSManaged public var next: String?
    @NSManaged public var pages: Int32
    @NSManaged public var prev: String?
    @NSManaged public var toCharacterData: CharacterDataCD?

}

extension InfoCD : Identifiable {

}
