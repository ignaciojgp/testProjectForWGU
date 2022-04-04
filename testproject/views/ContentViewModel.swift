
import Foundation
import RxSwift

protocol GetRegistersUseCaseProtocol {
    func execute() -> Single<[AbilityCellViewModel]>
}

class ContentViewModel: ObservableObject {
    @Published var items: [AbilityCellViewModel] = []
    let getRegistersUseCase: GetRegistersUseCaseProtocol
    let disposeBag = DisposeBag()
    
    init(getRegistersUseCase: GetRegistersUseCaseProtocol) {
        self.getRegistersUseCase = getRegistersUseCase
    }
    
    public func fetch() {
        getRegistersUseCase.execute().subscribe(onSuccess: { items in
            DispatchQueue.main.async {
                self.items = items
            }
        }, onFailure: { error in
            
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
    }
}
