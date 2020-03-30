import RxSwift
import RxCocoa

class AuthorizationLoadedViewModel {
    typealias DI = HasAuthSchemeSubmitter

    struct IdAndFieldViewModel {
        let id: String
        let viewModel: AuthTextFieldViewModel
    }

    let viewModels: [IdAndFieldViewModel]
    let submitionState: BehaviorRelay<SubmitionState>
    let disposeBag = DisposeBag()

    enum SubmitionState {
        case idle
        case loading
        case success
        case failed(Error)
    }

    init(scheme: AuthSchemeDTO, submit: Observable<Void>, di: DI) {
        let viewModels = scheme.fields.map { field -> IdAndFieldViewModel in
            let viewModel = AuthTextFieldViewModel(title: field.title, subtitle: field.subtitle)
            return IdAndFieldViewModel(id: field.id, viewModel: viewModel)
        }
        self.viewModels = viewModels

        let submitionState = BehaviorRelay<SubmitionState>(value: .idle)
        self.submitionState = submitionState

        submit
            .withLatestFrom(submitionState)
            .flatMapLatest { state -> Single<Void> in
                switch state {
                case .idle, .failed:
                    return .just(())
                case .loading, .success:
                    return .never()
                }
            }
            .do(onNext: { _ in
                submitionState.accept(.loading)
            })
            .flatMapLatest { _ -> Single<Void> in
                let fields = viewModels.map { viewModel in
                    AuthSchemeSubmitionDTO.Field(id: viewModel.id, value: viewModel.viewModel.value.value)
                }
                let submition = AuthSchemeSubmitionDTO(fields: fields)
                return di.authSchemeSubmitter.submit(submition)
            }
            .map { _ in
                SubmitionState.success
            }
            .catchError { error in
                .just(SubmitionState.failed(error))
            }
            .bind(to: submitionState)
            .disposed(by: disposeBag)

        submitionState
            .debug("AuthorizationLoaded state")
            .subscribe()
            .disposed(by: disposeBag)

    }
}
