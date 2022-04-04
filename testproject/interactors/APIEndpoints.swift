import Foundation

enum ApiEndpoints {
    case abilities
    case unexistentEndpoint
    case badUrl

    
    func getPath() -> String {
        switch self {
        case .abilities:
            return "pokemon/ditto"
        case .unexistentEndpoint:
            return "sometihingThatDoesntExists/"
        case .badUrl:
            return "*/*/asdasdñ    adsadas"
            
            
        }
    }
}

enum APIConstants {
    static let host = "https://pokeapi.co/api/v2"
}
