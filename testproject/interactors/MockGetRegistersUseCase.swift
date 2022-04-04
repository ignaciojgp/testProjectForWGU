import Foundation
import RxSwift

struct MockGetRegistersUseCase: GetRegistersUseCaseProtocol {
    func execute() -> Single<[AbilityCellViewModel]> {
        .just([
            .init(name: "Some name", description: "hidden: no, slot: 1")
        ])
    }
}
