import Foundation
import XCTest

extension XCTestCase {

    func asyncWait(for timeInterval: TimeInterval) {
        let waitExpectation = self.expectation(description: "WAIT \(Date().timeIntervalSince1970)")
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + timeInterval) {
            waitExpectation.fulfill()
        }
        wait(for: [waitExpectation], timeout: max(timeInterval * 2, 1))
    }

}
