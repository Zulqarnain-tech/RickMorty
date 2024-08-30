import Foundation

public protocol ViewModel: ObservableObject {
    associatedtype State: Equatable
    associatedtype Action
    func dispatch(_ action: Action) async
}

public struct EmptyState: Equatable {}
