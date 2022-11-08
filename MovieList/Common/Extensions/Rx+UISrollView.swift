import RxSwift
import RxCocoa
import Foundation

extension Reactive where Base: UIScrollView {

    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = base.frame.height - base.contentInset.top - base.contentInset.bottom
            let yPos = contentOffset.y + base.contentInset.top
            let threshold = max(offset, base.contentSize.height - visibleHeight)
            return yPos >= threshold
        }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in () }
        return ControlEvent(events: source)
    }
}
