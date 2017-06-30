import Foundation
import Result
import ReactiveSwift

public func scopedExample(_ exampleDescription: String, _ action: () -> Void) {
    print("\n--- \(exampleDescription) ---\n")
    action()
}

public enum PlaygroundError: Error {
    case example(String)
}

public var numberProperty: MutableProperty<Int> {
    return MutableProperty<Int>(0)
}

public var letterProperty: MutableProperty<String> {
    return MutableProperty<String>("nil")
}

public var numberPipe: (output: Signal<Int, NoError>, input: Signal<Int, NoError>.Observer) {
    return Signal<Int, NoError>.pipe()
}

public var letterPipe: (output: Signal<String, NoError>, input: Signal<String, NoError>.Observer) {
    return Signal<String, NoError>.pipe()
}
