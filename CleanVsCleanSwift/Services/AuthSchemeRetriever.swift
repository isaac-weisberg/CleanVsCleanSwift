import RxSwift

enum AuthSchemeTypeDTO {
    case stub
}

struct AuthSchemeDTO {
    struct Field {
        let id: String
        let title: String
        let subtitle: String
    }

    let fields: [Field]
}

protocol AuthSchemeRetrieverProtocol {
    func retrieve(_ scheme: AuthSchemeTypeDTO) -> Single<AuthSchemeDTO>
}

class AuthSchemeRetrieverFakeImpl: AuthSchemeRetrieverProtocol {
    func retrieve(_ scheme: AuthSchemeTypeDTO) -> Single<AuthSchemeDTO> {
        return Single.just(AuthSchemeDTO(
            fields: [
                AuthSchemeDTO.Field(
                    id: "qienrfhqurifhi3uh4f93h4f834hf",
                    title: "Your card number",
                    subtitle: "In dis field you are supposed to put them digist, you know"
                ),
                AuthSchemeDTO.Field(
                    id: "qienrfhqurikq43oifjq04j",
                    title: "Expiration MM/YY",
                    subtitle: "HEY KIDS! YABBA DABBA DOO ME A FAVOR AND SHARE YOUR PARENT'S CREDIT CARD INFORMATION"
                ),
                AuthSchemeDTO.Field(
                    id: "qienqeroifj03m4ii3uh4f93h4f834hf",
                    title: "CVV",
                    subtitle: "What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals, and I've been involved in numerous secret raids on Al-Quaeda, and I have over 300 confirmed kills. I am trained in gorilla warfare and I'm the top sniper in the entire US armed forces. You are nothing to me but just another target. I will wipe you the fuck out with precision the likes of which has never been seen before on this Earth, mark my fucking words. You think you can get away with saying that shit to me over the Internet? Think again, fucker. As we speak I am contacting my secret network of spies across the USA and your IP is being traced right now so you better prepare for the storm, maggot. The storm that wipes out the pathetic little thing you call your life. You're fucking dead, kid. I can be anywhere, anytime, and I can kill you in over seven hundred ways, and that's just with my bare hands. Not only am I extensively trained in unarmed combat, but I have access to the entire arsenal of the United States Marine Corps and I will use it to its full extent to wipe your miserable ass off the face of the continent, you little shit. If only you could have known what unholy retribution your little \"clever\" comment was about to bring down upon you, maybe you would have held your fucking tongue. But you couldn't, you didn't, and now you're paying the price, you goddamn idiot. I will shit fury all over you and you will drown in it. You're fucking dead, kiddo."
                ),
            ]
        ))
        .delay(.seconds(3), scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
    }
}
