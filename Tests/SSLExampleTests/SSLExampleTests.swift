import XCTest
@testable import SSLExample

class SSLExampleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SSLExample().text, "Hello, World!")
    }


    static var allTests : [(String, (SSLExampleTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
