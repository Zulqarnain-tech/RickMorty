//
//  File.swift
//  
//
//  Created by Zulqarnain Naveed Macbook on 30/08/2024.
//

import Foundation
import Domain


extension LocationCD{
    func convertToLocationEntity()-> Location{
        return Location(name: self.name ?? "", url: self.url ?? "")
    }
}

extension InfoCD{
    func convertToInfoEntity()-> Info{
        return Info(count: Int(self.count), pages: Int(self.pages), next: self.next ?? "", prev: self.prev)
    }
}

extension ResultCD{
    func convertToInfoEntity()-> Result{
        return Result(id: Int(self.id), name: self.name ?? "", status: self.status ?? "", species: self.species ?? "", type: self.type ?? "", gender: self.gender ?? "",
                      origin: self.origin?.convertToLocationEntity() ?? Location(name: "", url: ""),
                      location: self.location?.convertToLocationEntity() ?? Location(name: "", url: ""),
                      image: self.image ?? "", episode: self.episode ?? [], url: self.url ?? "", created: self.created ?? "")
    }
    
}

extension CharacterDataCD{
    func convertToCharacterDataEntity()-> CharacterDataEntity{
        return CharacterDataEntity(info: self.toInfo?.convertToInfoEntity() ?? Info(count: 0, pages: 0, next: "", prev: ""), results: self.convertResultlArray() ?? [])
    }
    
    private func convertResultlArray()->[Result]?{
        guard self.toResult != nil && self.toResult?.count != 0 else {return nil}

        var resultArray: [Result] = []

        self.toResult?.forEach({ (resultCD) in
            resultArray.append(resultCD.convertToInfoEntity())
        })

        return resultArray
    }
}
