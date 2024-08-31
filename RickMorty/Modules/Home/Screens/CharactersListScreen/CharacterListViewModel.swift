import Foundation
import DesignSystem
import Domain
import Dependencies

final class CharacterListViewModel: ViewModel {
    
    
    struct State: Equatable {
        var characterData: CharacterDataEntity?
        var originalCharacterList: [Result] = []
        var error: Toast?
        var isLoading = false
        var sliderImages: [String] = ["img_home1", "img_home2", "img_home3"]
    }
    enum Action {
        case onAppear
        case characterTapped(Result)
    }

   
    // MARK: - Dependencies
    @Dependency(\.characterDataUseCase)
    private var characterDataUseCase
    
    @Dependency(\.coreDataService)
    private var coreDataService
    
    
    // MARK: - Publishers
    @Published var state: State  = .init()
    @Published var movedFromDetailScreen: Bool = false
    @Published var charactersList: [Result] = []
    @Published var lastKnownLocation: [String] = []
    @Published var selectedKnown: String = "All"{
        didSet{
            if selectedKnown == "All"{
                charactersList = self.state.originalCharacterList
            }else{
                self.charactersList = self.state.originalCharacterList.filter { $0.location.name == selectedKnown }
            }
           
        }
    }
    @Published var firstSeenList: [String] = []
    @Published var selectedFirstSeen: String = ""{
        didSet{
            if selectedFirstSeen == ""{
                charactersList = self.state.originalCharacterList
            }else{
                self.charactersList = self.state.originalCharacterList.filter { $0.episode[0].contains(selectedFirstSeen.replacingOccurrences(of: "Episode ", with: "")) }
            }
            
        }
    }
    @Published var searchText: String = ""
    @Published var isEdit: Bool = false
    @Published var selectedStatus: CharacterStatusSegment = .alive {
        didSet {
            switch selectedStatus {
            case .alive:
                if selectedSpecies == .robot{
                    selectedSpecies = .alien
                }
               debugPrint("call alive")
            case .dead:
                debugPrint("call dead")

            }
            Task{
                await fetchCharacterDataRemote( name: "", species: selectedSpecies.title, status: selectedStatus.title)
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
                if selectedStatus == .alive{
                    selectedStatus = .dead
                }
                debugPrint("call robot")
            }
            Task{
                await fetchCharacterDataRemote( name: "", species: selectedSpecies.title, status: selectedStatus.title)
            }
        }
    }
    @Published var firstSeenIn: Bool = false
    @Published var knownLocation: Bool = false
    @Published var tappedCharacter: Int = -1
    
    
    // MARK: - Variables
    private let onCharacterSelected: (Result) -> Void
    
    
    init(
        onCharacterSelected: @escaping (Result) -> Void
    ) {
        self.onCharacterSelected = onCharacterSelected
    }

    func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await fetchCharacterData()
        case .characterTapped(let character):
            self.movedFromDetailScreen = true
            await select(character)
        }
    }


    


    @MainActor
    private func handleLoading(_ isLoading: Bool) {
        state.isLoading = isLoading
    }
    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? CharacterListErrorEntity else {
            state.error = .init(style: .error, message: error.localizedDescription)
            return
        }
        state.error = .init(style: .error, message: error.description)
    }

    @MainActor private func select(_ character: Result) {
        onCharacterSelected(character)
    }
    
     @MainActor
     private func fillCharactersList(_ characters: [Result]) {
         DispatchQueue.main.async {
             self.charactersList = characters
             self.state.originalCharacterList = characters
         }
             
         
     }
}


// MARK: - Fetch Data From Local/Remote Source
extension CharacterListViewModel{
    func fetchCharacterData(searchedQuery: Bool = false) async {
        
        let characterData: CharacterDataEntity? =  coreDataService.fetch()
        if let characterData = characterData, characterData.results.count != 0, !searchedQuery {
            await fillCharactersList(characterData.results)
            resetLastKnownLocationFilter(characterData: characterData)
            resetFirstSeenFilter(characterData: characterData)
        } else {
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                await fetchCharacterDataRemote( name: searchText, species: selectedSpecies.title, status: selectedStatus.title)
            }else{
                await fetchCharacterDataRemote( name: searchText, species: selectedSpecies.isEmpty, status: selectedStatus.isEmpty)
            }
        }
    }
    private func fetchCharacterDataRemote(name: String?,species: String?, status: String?) async {
        await handleLoading(true)

        do {
            let characterData = try await characterDataUseCase.getcharactersList(name: name, species: species, status: status)
            await handleLoading(false)
            await fillCharactersList(characterData.results)
            coreDataService.create(record: characterData)
            resetLastKnownLocationFilter(characterData: characterData)
            resetFirstSeenFilter(characterData: characterData)
            
        } catch let error {
            await handleLoading(false)
            await handleError(error)
        }
    }
}

// MARK: - Reset Filters
extension CharacterListViewModel{
    private func resetLastKnownLocationFilter(characterData: CharacterDataEntity){
        DispatchQueue.main.async {
            self.lastKnownLocation = Array(Set(characterData.results.map { $0.location.name }))
            self.lastKnownLocation.insert("All", at: 0)
            self.selectedKnown = "All"
            self.knownLocation = false
        }
    }
    
    private func resetFirstSeenFilter(characterData: CharacterDataEntity){
        DispatchQueue.main.async {
            self.firstSeenList = Array(Set(characterData.results.compactMap({$0.episode[0].replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "Episode ")})))
            self.selectedFirstSeen = ""
            self.firstSeenIn = false
        }
    }
}
