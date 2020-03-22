import UIKit
import RxSwift
import RxCocoa

class AuthSchemaView: UIView {
    var disposeBag: DisposeBag!
    var viewModel: AuthSchemaViewModelProtocol!

    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        [stackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        [stackView].forEach(addSubview(_:))

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        stackView.axis = .vertical
    }

    func apply(viewModel: AuthSchemaViewModelProtocol) {
        self.viewModel = viewModel
        disposeBag = DisposeBag()

        viewModel.fields
            .bind(onNext: { [stackView] fields in
                stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview(_:))
                fields.forEach { fieldVM in
                    let fieldView = AuthTextField()
                    fieldView.translatesAutoresizingMaskIntoConstraints = false
                    fieldView.apply(viewModel: fieldVM)
                    stackView.addArrangedSubview(fieldView)
                }
            })
            .disposed(by: disposeBag)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
