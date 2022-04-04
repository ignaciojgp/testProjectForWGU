import Foundation

struct PokeApiResponse: Decodable {
    let abilities: [AbilityHolder]
}

