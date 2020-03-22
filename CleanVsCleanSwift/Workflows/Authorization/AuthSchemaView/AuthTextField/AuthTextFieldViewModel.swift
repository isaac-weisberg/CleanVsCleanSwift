import RxSwift
import RxCocoa

protocol AuthTextFieldViewModelProtocol {
    var title: String { get }

    var subtitle: String { get }

    var value: BehaviorRelay<String> { get }
}

struct AuthTextFieldViewModel: AuthTextFieldViewModelProtocol {
    let title: String
    let subtitle: String
    let value: BehaviorRelay<String>

    init(title: String, subtitle: String, initialValue: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.value = BehaviorRelay(value: initialValue)
    }
}
