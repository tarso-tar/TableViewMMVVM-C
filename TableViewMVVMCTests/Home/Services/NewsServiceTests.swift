//
//  NewsServiceTests.swift
//  TableViewMVVMCTests
//
//  Created by Saulo Oliveira on 04/12/22.
//

import XCTest
@testable import TableViewMVVMC

class NewsServiceTests: XCTestCase {
    
    var sut: NewsService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NewsService(urlString: "https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16254158?start=1#overview", urlSession: urlSession)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        MockURLProtocol.stubResponseData = nil
        
    }
    
    func testNewsService_WhenGivenSucessfulResponse_ReturnsSucess() {
        
        // Arrange
        guard let path = Bundle(for: type(of: self)).path(forResource: "NewsJsonMock", ofType: "json") else {
            XCTFail("Invalid mock Json")
            return
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        
        MockURLProtocol.stubResponseData = data!
        //MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "NewsService response expectation")
        // Act
        sut.getTopNews() { (result) in
            
            // Assert
            switch result {
            case .success(let posts):
                print("Returned posts", posts)
                XCTAssertFalse(posts.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("NewsService should not return error when given sucessful response, error ->  \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testNewsService_WhenReceivedUnknowJsonResponse_ReturnsFailedDecodingError() {
        
        // Arrange
        let jsonString = "\"aaa\":\"bbb\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "NewsService response expectation")
        // Act
        sut.getTopNews() { (result) in
            
            // Assert
            switch result {
            case .success(_):
                XCTFail("NewsService should not return sucess when given invalid json response")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(NewsServiceError.failedDecoding, error, "ckeck for contract alteration in api, error -> \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testNewsService_WhenInvalidURLProvided_ReturnsInvalidURLError() {
        // Arrange
        sut = NewsService(urlString: "invalidURL ")
        let expectation = self.expectation(description: "Invalid URL expectation")
        // Act
        sut.getTopNews { result in
            // Assert
            switch result {
            case .success(_):
                XCTFail("Should not return sucess when given invalid url")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, NewsServiceError.invalidURL)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
