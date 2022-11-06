import RxSwift

extension ObserverType where Element == Void {
    public func onNext() {
        onNext(())
    }
}
