import SwiftUI
import Domain
import Data

final class MainCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var navigationControllerEventPicker: UINavigationController?

    public init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func begin() {
        let vc = MainScreenView(
            viewModel: CharacterListViewModel(
                onAstronomySelected: {
                    self.showAstronomyDetails($0)
                }
            )
        ).hosted

        pushViewController(vc, animated: true)
    }

    func showAstronomyDetails(_ character: Result) {
        let vc = CharacterDetailScreen(
            viewModel: CharacterDetailsViewModel(character: character, onMoveBack: {
                self.popNavigationView()
            })
        ).hosted

        pushViewController(vc, animated: true)
    }
    func popNavigationView() {
        navigationController.popViewController(animated: true)
    }
}
