import RxSwift

struct AuthSchemeSubmitionDTO {
    struct Field {
        let id: String
        let value: String
    }

    let fields: [Field]
}

protocol AuthSchemeSubmitterProtocol {
    func submit(_ scheme: AuthSchemeSubmitionDTO) -> Single<Void>
}

struct AuthSchemeSubmitterFakeImpl: AuthSchemeSubmitterProtocol {
    func submit(_ scheme: AuthSchemeSubmitionDTO) -> Single<Void> {
        print("fuch fuckksdfsdf", scheme)
        return Single.just(())
            .delay(.seconds(3), scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
    }
}
