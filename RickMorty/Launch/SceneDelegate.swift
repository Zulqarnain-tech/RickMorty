import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        print("Current environment is: \(Environment.current)")
        print("Current base URL is: \(Configuration.baseUrl ?? "")")

        let applicationWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        applicationWindow.windowScene = windowScene

        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true

        coordinator = MainCoordinator(
            navigationController: navigationController
        )
        coordinator?.begin()

        applicationWindow.rootViewController = navigationController
        applicationWindow.makeKeyAndVisible()

        window = applicationWindow
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
    }
}
