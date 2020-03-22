import UIKit
import RxSwift
import RxCocoa

class AuthTextField: UIView {
    var viewModel: AuthTextFieldViewModelProtocol!
    var disposeBag: DisposeBag!

    let titleLabel = UILabel()
    let textField = InsetTextField()
    let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        [titleLabel, textField, subtitleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        [titleLabel, textField, subtitleLabel].forEach(addSubview(_:))

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            subtitleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        subtitleLabel.numberOfLines = 0

        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 8
    }

    func apply(viewModel: AuthTextFieldViewModelProtocol) {
        disposeBag = DisposeBag()
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle

        viewModel.value
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)

        textField.rx.text
            .orEmpty
            .bind(to: viewModel.value)
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
