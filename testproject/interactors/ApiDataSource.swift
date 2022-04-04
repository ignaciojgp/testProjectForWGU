import UIKit
import RxSwift

enum ApiDataSourceErrors: Error {
    case unexpected
    case wrongURL
    case wrongHost
    case wrongStatusCode
}

class ApiDataSource: ApiDataSouceProtocol {
    public func callApi(endpoint: ApiEndpoints) -> Single<Data> {
        .create { handler in
            
            guard let url = URL(string: "\(APIConstants.host)/\(endpoint.getPath())") else {
                handler(.failure(ApiDataSourceErrors.wrongURL))
                return Disposables.create()
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    handler(.failure(error))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("error \(httpResponse.statusCode)")
                    if !(200...300 ~= httpResponse.statusCode) {
                        handler(.failure(ApiDataSourceErrors.wrongStatusCode))
                        return
                    }
                }
                if let data = data {
                    print(String(data: data, encoding: .utf8) ?? "unable to read data")
                    handler(.success(data))
                }
                
            }.resume()
            return Disposables.create()
        }        
    }
}
