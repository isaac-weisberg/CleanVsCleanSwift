protocol AuthTextFieldCSViewProtocol: class {
    func setTitleAndSubtitle(_ title: String, _ subtitle: String)

    func setFieldValue(_ value: String)
}

class AuthTextFieldCSPresenter {
    weak var view: AuthTextFieldCSViewProtocol?

    init(_ title: String, _ subtitle: String, view: AuthTextFieldCSViewProtocol) {
        self.view = view
        view.setTitleAndSubtitle(title, subtitle)
    }

    func setFieldValue(_ value: String) {
        view?.setFieldValue(value)
    }
}
