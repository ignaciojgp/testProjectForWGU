import XCTest
import RxSwift
@testable import testproject

class testprojectTests: XCTestCase {
    
    var dataSource: MockApiDataSource!
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        dataSource = MockApiDataSource()
    }

    func testUseCaseShouldSuccess() throws {
        let requestExpectation = expectation(description: "response expectation")
        let useCase = GetRegistersUseCase(dataSource: dataSource)
        useCase.execute().subscribe { result in
            requestExpectation.fulfill()
            XCTAssertEqual(result.count, 2)
        } onFailure: { error in
            XCTFail(error.localizedDescription)
        }.disposed(by: disposeBag)
        wait(for: [requestExpectation], timeout: 1)
    }
    
    func testUseCaseShouldFail() throws {
        let failExpectation = expectation(description: "response expectation")
        let useCase = GetRegistersUseCase(dataSource: dataSource)
        dataSource.mode = .failure
        useCase.execute().subscribe { result in
            XCTFail("unexpected success")
        } onFailure: { error in
            XCTAssertNotNil(error)
            failExpectation.fulfill()
        }.disposed(by: disposeBag)
        wait(for: [failExpectation], timeout: 1)
    }

    func testApiDataSourceShouldSuccess() throws {
        let requestExpectation = expectation(description: "request expectation")
        let apiDataSource = ApiDataSource()
        apiDataSource.callApi(endpoint: .abilities).subscribe { data in
            requestExpectation.fulfill()
            XCTAssert(data.count > 0)
        } onFailure: { error in
            XCTFail(error.localizedDescription)
        }.disposed(by: disposeBag)
        wait(for: [requestExpectation], timeout: 5)
    }
    
    func testApiDataSourceShouldFail() throws {
        let requestExpectation = expectation(description: "request expectation")
        let apiDataSource = ApiDataSource()
        apiDataSource.callApi(endpoint: .badUrl).subscribe { data in
            XCTFail("unexpected success")
        } onFailure: { error in
            switch error {
            case ApiDataSourceErrors.wrongURL:
                requestExpectation.fulfill()
            default:
                XCTFail("wrong error")
            }
        }.disposed(by: disposeBag)
        wait(for: [requestExpectation], timeout: 5)
    }
    
    func testApiDataSourceShouldFailForUnexistingEndpoint() throws {
        let requestExpectation = expectation(description: "request expectation")
        let apiDataSource = ApiDataSource()
        apiDataSource.callApi(endpoint: .unexistentEndpoint).subscribe { data in
            XCTFail("unexpected success")
        } onFailure: { error in
            switch error {
            case ApiDataSourceErrors.wrongStatusCode:
                requestExpectation.fulfill()
            default:
                XCTFail("wrong error")
            }
        }.disposed(by: disposeBag)
        wait(for: [requestExpectation], timeout: 5)
    }
    
}
