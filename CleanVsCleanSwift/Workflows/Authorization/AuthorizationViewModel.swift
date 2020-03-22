import RxSwift
import RxCocoa

protocol AuthorizationViewModelProtocol {
    var authSchemaViewModel: AuthSchemaViewModelProtocol { get }

    var submitPressed: PublishRelay<Void> { get }
}

class AuthVMStub: AuthorizationViewModelProtocol {
    typealias DI = HasAuthSchemeRetriever
        & AuthorizationLoadedViewModel.DI

    let authSchemaViewModel: AuthSchemaViewModelProtocol
    let submitPressed: PublishRelay<Void>

    let disposeBag = DisposeBag()

    init(di: DI) {
        enum State {
            case loading
            case loaded(AuthorizationLoadedViewModel)
            case failed(Error)
        }

        let submitPressed = PublishRelay<Void>()
        self.submitPressed = submitPressed

        let state = BehaviorRelay<State>(value: .loading)

        di.authSchemeRetriever.retrieve(.stub)
            .map { scheme -> State in
                let viewModel = AuthorizationLoadedViewModel(
                    scheme: scheme,
                    submit: submitPressed.asObservable(),
                    di: di
                )
                return .loaded(viewModel)
            }
            .catchError { error in
                .just(State.failed(error))
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { newState in
                state.accept(newState)
            })
            .disposed(by: disposeBag)

        let fieldViewModels = state
            .flatMapLatest { state -> Single<[AuthorizationLoadedViewModel.IdAndFieldViewModel]> in
                switch state {
                case .loaded(let viewModel):
                    return .just(viewModel.viewModels)
                case .failed, .loading:
                    return .never()
                }
            }
            .distinctUntilChanged { oldFields, newFields in
                oldFields.map { $0.id } == newFields.map { $0.id }
            }
            .map { $0.map { $0.viewModel as AuthTextFieldViewModelProtocol }}

        authSchemaViewModel = AuthSchemaViewModel(fields: fieldViewModels)
    }
}
