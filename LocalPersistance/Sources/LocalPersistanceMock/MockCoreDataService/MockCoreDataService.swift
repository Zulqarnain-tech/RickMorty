//
//  File.swift
//  
//
//  Created by Zulqarnain Naveed Macbook on 31/08/2024.
//

import Foundation
import Domain
import LocalPersistance


public class MockCoreDataService: LocalServiceProtocol {
    
    public typealias T = CharacterDataEntity
    
    // Mock storage to simulate Core Data
    private var mockStorage: CharacterDataEntity?

    // You can initialize it with optional data for specific tests
    public init(initialData: CharacterDataEntity? = nil) {
        self.mockStorage = initialData
    }

    public func create(record: CharacterDataEntity) {
        // Store the record in mockStorage
        self.mockStorage = record
    }

    public func fetch() -> CharacterDataEntity? {
        // Return the stored data
        return self.mockStorage
    }
}
