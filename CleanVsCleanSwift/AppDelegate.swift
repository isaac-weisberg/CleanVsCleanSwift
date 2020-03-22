import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let dependencies = AllDependencies()

        let controller = AuthorizationController()
        let viewModel = AuthVMStub(di: dependencies)

        controller.apply(viewModel: viewModel)

        window.rootViewController = controller
        window.makeKeyAndVisible()

        return true
    }
}
