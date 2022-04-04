import Foundation


struct AbilityHolder: Decodable, Identifiable {
    var id = UUID()
    
    let ability: AbilityModel
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability = "ability"
        case isHidden = "is_hidden"
        case slot = "slot"
    }
}

struct AbilityModel: Decodable {
    let name: String?
    let url: String?
}
