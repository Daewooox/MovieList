import XCoordinator
import XCTest

class TestAnimation: Animation {

    static func `static`(presentation: XCTestExpectation, dismissal: XCTestExpectation) -> TestAnimation {
        return TestAnimation(
            presentation: TestAnimation.staticTransitionAnimation(for: presentation),
            dismissal: TestAnimation.staticTransitionAnimation(for: dismissal)
        )
    }

    static func interactive(presentation: XCTestExpectation, dismissal: XCTestExpectation) -> TestAnimation {
        return TestAnimation(
            presentation: TestAnimation.interactiveTransitionAnimation(for: presentation),
            dismissal: TestAnimation.interactiveTransitionAnimation(for: dismissal)
        )
    }

    private static func interactiveTransitionAnimation(for expectation: XCTestExpectation?) -> TransitionAnimation {
        return InteractiveTransitionAnimation(duration: 0.1) {
            expectation?.fulfill()
            $0.completeTransition(true)
        }
    }

    private static func staticTransitionAnimation(for expectation: XCTestExpectation?) -> TransitionAnimation {
        return StaticTransitionAnimation(duration: 0.1) {
            expectation?.fulfill()
            $0.completeTransition(true)
        }
    }

}
