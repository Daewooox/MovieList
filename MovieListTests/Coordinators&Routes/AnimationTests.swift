import UIKit
import XCoordinator
import XCTest

class AnimationTests: XCTestCase {

    static let allTests = [
        ("testViewCoordinator", testViewCoordinator),
        ("testNavigationCoordinator", testNavigationCoordinator),
    ]

    private lazy var window = UIWindow()

    func testViewCoordinator() {
        let coordinator = ViewCoordinator<TestRoute>(rootViewController: .init())
        coordinator.setRoot(for: window)
        testStandardAnimationsCalled(on: coordinator)
    }

    func testNavigationCoordinator() {
        let coordinator = NavigationCoordinator<TestRoute>(root: UIViewController())
        coordinator.setRoot(for: window)
        testStandardAnimationsCalled(on: coordinator)

        testStaticAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testStaticAnimationCalled(on: coordinator, transition: { .pop(animation: $0) })

        testInteractiveAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testInteractiveAnimationCalled(on: coordinator, transition: { .pop(animation: $0) })

        testStaticAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testStaticAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testStaticAnimationCalled(on: coordinator, transition: { .popToRoot(animation: $0) })

        testInteractiveAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testInteractiveAnimationCalled(on: coordinator, transition: { .push(UIViewController(), animation: $0) })
        testInteractiveAnimationCalled(on: coordinator, transition: { .popToRoot(animation: $0) })

        let staticViewControllers = [UIViewController(), UIViewController()]
        testStaticAnimationCalled(on: coordinator, transition: { .set(staticViewControllers, animation: $0) })
        testStaticAnimationCalled(on: coordinator, transition: { .pop(to: staticViewControllers[0], animation: $0) })

        let interactiveViewControllers = [UIViewController(), UIViewController()]
        testInteractiveAnimationCalled(on: coordinator, transition: { .set(interactiveViewControllers, animation: $0) })
        testInteractiveAnimationCalled(
            on: coordinator,
            transition: { .pop(to: interactiveViewControllers[0], animation: $0) }
        )
    }

    // MARK: Helpers

    private func testStandardAnimationsCalled<C: Coordinator, RootViewController>(on coordinator: C) where C.TransitionType == Transition<RootViewController> {
        testStaticAnimationCalled(on: coordinator, transition: { .present(UIViewController(), animation: $0) })
        testStaticAnimationCalled(on: coordinator, transition: { .dismiss(animation: $0) })
        testStaticAnimationCalled(
            on: coordinator,
            transition: { .multiple(.present(UIViewController(), animation: nil), .dismiss(animation: $0)) }
        )
        testStaticAnimationCalled(
            on: coordinator,
            transition: { .multiple(.present(UIViewController(), animation: $0), .dismiss(animation: .default)) }
        )

        testInteractiveAnimationCalled(on: coordinator, transition: { .present(UIViewController(), animation: $0) })
        testInteractiveAnimationCalled(on: coordinator, transition: { .dismiss(animation: $0) })
        testInteractiveAnimationCalled(
            on: coordinator,
            transition: { .multiple(.present(UIViewController(), animation: $0), .dismiss(animation: .default)) }
        )
    }

    private func testStaticAnimationCalled<C: Coordinator>(on coordinator: C,
                                                           transition: (Animation) -> C.TransitionType) {
        let animationExpectation = expectation(description: "Animation \(Date().timeIntervalSince1970)")
        let completionExpectation = expectation(description: "Completion \(Date().timeIntervalSince1970)")
        let testAnimation = TestAnimation.static(presentation: animationExpectation, dismissal: animationExpectation)
        let t = transition(testAnimation)
        coordinator.performTransition(t, with: TransitionOptions(animated: true)) {
            completionExpectation.fulfill()
        }
        wait(for: [animationExpectation, completionExpectation], timeout: 3, enforceOrder: true)
        asyncWait(for: 0.1)
    }

    private func testInteractiveAnimationCalled<C: Coordinator>(on coordinator: C,
                                                                transition: (Animation) -> C.TransitionType) {
        let animationExpectation = expectation(description: "Animation \(Date().timeIntervalSince1970)")
        let completionExpectation = expectation(description: "Completion \(Date().timeIntervalSince1970)")
        let testAnimation = TestAnimation.interactive(
            presentation: animationExpectation,
            dismissal: animationExpectation
        )
        let t = transition(testAnimation)
        coordinator.performTransition(t, with: TransitionOptions(animated: true)) {
            completionExpectation.fulfill()
            _ = testAnimation
        }
        wait(for: [animationExpectation, completionExpectation], timeout: 3, enforceOrder: true)
        asyncWait(for: 0.1)
    }
}
