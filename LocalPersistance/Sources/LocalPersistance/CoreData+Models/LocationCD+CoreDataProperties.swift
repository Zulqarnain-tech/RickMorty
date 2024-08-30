//
//  LocationCD+CoreDataProperties.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 30/08/2024.
//
//

import Foundation
import CoreData


extension LocationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCD> {
        return NSFetchRequest<LocationCD>(entityName: "LocationCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var locationInfo: ResultCD?
    @NSManaged public var originInfo: ResultCD?

}

extension LocationCD : Identifiable {

}
