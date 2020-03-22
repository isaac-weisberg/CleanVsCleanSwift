import RxSwift

protocol AuthSchemaViewModelProtocol {
    var fields: Observable<[AuthTextFieldViewModelProtocol]> { get }
}

struct AuthSchemaViewModel: AuthSchemaViewModelProtocol {
    let fields: Observable<[AuthTextFieldViewModelProtocol]>
}
