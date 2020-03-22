import UIKit

class AuthorizationController: UIViewController {
    let authView = AuthorizationView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view = authView
    }

    func apply(viewModel: AuthorizationViewModelProtocol) {
        authView.apply(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
