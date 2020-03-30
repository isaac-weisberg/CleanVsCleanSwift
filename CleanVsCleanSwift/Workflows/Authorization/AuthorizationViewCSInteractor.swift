protocol AuthorizationViewCSInteractorProtocol {
    func submit()
}

class AuthorizationViewCSInteractor: AuthorizationViewCSInteractorProtocol {
    let presenter: AuthorizationViewCSPresenterProtocol

    init(presenter: AuthorizationViewCSPresenterProtocol) {
        self.presenter = presenter
    }

    func submit() {
        
    }
}
