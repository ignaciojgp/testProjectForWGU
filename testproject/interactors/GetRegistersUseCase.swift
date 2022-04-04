import UIKit
import RxSwift

protocol ApiDataSouceProtocol {
    func callApi(endpoint: ApiEndpoints) -> Single<Data>
}

struct GetRegistersUseCase: GetRegistersUseCaseProtocol {
    let dataSource: ApiDataSouceProtocol
    
    func execute() -> Single<[AbilityCellViewModel]> {
        dataSource.callApi(endpoint: .abilities).map { data in
            let response = try JSONDecoder().decode(PokeApiResponse.self, from: data)
            return response.toAbilityCellViewModelList()
        }
    }
}

extension PokeApiResponse {
    func toAbilityCellViewModelList() -> [AbilityCellViewModel]{
        abilities.map { abilityHolder in
            AbilityCellViewModel(
                id: UUID(),
                name: abilityHolder.ability.name ?? "",
                description: "hidden: \(abilityHolder.isHidden ? "no":"yes"), slot: \(abilityHolder.slot)")
        }
    }
}
