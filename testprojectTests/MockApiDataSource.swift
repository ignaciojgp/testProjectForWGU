import Foundation
import RxSwift
@testable import testproject
import XCTest

enum MockApiDataSourceErrors: Error {
    case wrongUrl
}

class MockApiDataSource: ApiDataSouceProtocol {
    
    enum Mode {
        case success
        case failure
    }
    
    var mode: Mode = .success
  
    func callApi(endpoint: ApiEndpoints) -> Single<Data> {
        
        switch mode {
        case .success:
            guard let data = try? jsonData(file: "example_response") else {
                return .error(MockApiDataSourceErrors.wrongUrl)
            }
            return .just(data)
        case .failure:
            return .error(MockApiDataSourceErrors.wrongUrl)
        }        
        
    }
    
    public func jsonData(file: String) throws -> Data {
        guard let url = Bundle(for: MockApiDataSource.self).url(forResource: file, withExtension: "json") else {
            throw MockApiDataSourceErrors.wrongUrl
        }
        guard let data = try? Data(contentsOf: url) else { fatalError("unable to retrieve data") }
        return data
    }

}
