import RxSwift

extension ObserverType where Element == Void {
    func onNext() {
        onNext(())
    }
}
