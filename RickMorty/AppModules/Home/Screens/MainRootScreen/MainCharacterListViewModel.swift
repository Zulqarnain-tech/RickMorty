//
//  MainCharacterListViewModel.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import Foundation
final class MainCharacterListViewModel: ObservableObject {
    struct State: Equatable {
//        var astronomies: [AstronomyEntity] = []
//        var error: Toast?
        var sliderImages: [String] = ["img_home1", "img_home2", "img_home3"]
        var isLoading = false
    }
    @Published var searchText: String = ""
    @Published var isEdit: Bool = false
    enum Action {
        case onAppear
        //case astronomyTapped(AstronomyEntity)
    }

    @Published var state: State  = .init()


    init() {
     
    }

}
