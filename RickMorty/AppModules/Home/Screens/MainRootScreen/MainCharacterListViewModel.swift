//
//  MainCharacterListViewModel.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import Foundation
final class MainCharacterListViewModel: ObservableObject {
    struct State: Equatable {

        var sliderImages: [String] = ["img_home1", "img_home2", "img_home3"]
        var isLoading = false
    }
    @Published var searchText: String = ""
    @Published var isEdit: Bool = false
    enum Action {
        case onAppear
        
    }

    @Published var state: State  = .init()
    
    @Published var selectedStatus: CharacterStatusSegment = .alive {
        didSet {
            switch selectedStatus {
            case .alive:
               debugPrint("call alive")
            case .dead:
                debugPrint("call dead")

            }
        }
    }
    @Published var selectedSpecies: CharacterSpeciesSegment = .alien {
        didSet {
            switch selectedSpecies {
            case .alien:
               debugPrint("call debugPrint")
            case .human:
                debugPrint("call human")
            case .robot:
                debugPrint("call robot")
            }
        }
    }
    
    @Published var firstSeenIn: Bool = false
    @Published var knownLocation: Bool = false
    @Published var tappedCharacter: Int = -1
    

    init() {
     
    }

}
