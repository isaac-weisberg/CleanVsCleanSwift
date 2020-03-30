protocol AuthTextFieldCSInteractorProtocol {
    func setFieldValue(_ value: String)
}

class AuthTextFieldCSInteractor {
    var value: String
    let presenter: AuthTextFieldCSPresenter

    init(_ initialValue: String = "", presenter: AuthTextFieldCSPresenter) {
        self.value = initialValue
        self.presenter = presenter
        presenter.setFieldValue(value)
    }

    func setFieldValue(_ value: String) {
        self.value = value
    }
}
