import UIKit
import RxSwift
import RxCocoa

class AuthorizationView: UIView {
    var disposeBag: DisposeBag!
    var viewModel: AuthorizationViewModelProtocol!

    let scrollView = UIScrollView()
    let authSchemaView = AuthSchemaView()
    let submitButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        [scrollView, authSchemaView, submitButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        scrollView.alwaysBounceVertical = true

        addSubview(scrollView)
        [authSchemaView, submitButton].forEach(scrollView.addSubview(_:))

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            authSchemaView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            authSchemaView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            authSchemaView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            authSchemaView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),

            submitButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: authSchemaView.bottomAnchor, constant: 8),
            submitButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
        ])

        submitButton.setTitle("Submit", for: .normal)

        scrollView.keyboardDismissMode = .onDrag
    }

    func apply(viewModel: AuthorizationViewModelProtocol) {
        self.viewModel = viewModel
        disposeBag = DisposeBag()

        authSchemaView.apply(viewModel: viewModel.authSchemaViewModel)

        submitButton.rx.tap
            .bind(to: viewModel.submitPressed)
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
