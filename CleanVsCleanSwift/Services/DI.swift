protocol HasAuthSchemeRetriever {
    var authSchemeRetriever: AuthSchemeRetrieverProtocol { get }
}

protocol HasAuthSchemeSubmitter {
    var authSchemeSubmitter: AuthSchemeSubmitterProtocol { get }
}

typealias HasAllDeps = HasAuthSchemeRetriever
    & HasAuthSchemeSubmitter

class AllDependencies: HasAllDeps {
    let authSchemeRetriever: AuthSchemeRetrieverProtocol
    let authSchemeSubmitter: AuthSchemeSubmitterProtocol

    init() {
        authSchemeRetriever = AuthSchemeRetrieverFakeImpl()
        authSchemeSubmitter = AuthSchemeSubmitterFakeImpl()
    }
}
