/*:
 > # IMPORTANT: To use `ReactiveSwift.playground`, please:

 1. Retrieve the project dependencies using one of the following terminal commands from the ReactivePlayground project root directory:

 if you do **NOT** have [Carthage](https://github.com/Carthage/Carthage) installed, please install it first before continuing.

 - `carthage update --no-build`

 Then

 1. Open `ReactivePlayground.xcworkspace`
 2. Open the `ReactiveSwift.playground`
 3. Choose `View > Show Debug Area`
 */

import Result
import ReactiveSwift
import ReactiveCocoa


scopedExample("sampleWith:") {

    let number = numberProperty
    let letter = letterProperty

    number.signal.sample(with: letter.signal).observeValues { values in
        print(values)
    }

    number.value = 1 // nothing printed
    number.value = 2 // nothing printed
    letter.value = "a" // prints (2, a)

}

scopedExample("flatten.merge") {
    let (lettersSignal, lettersObserver) = Signal<String, NoError>.pipe()
    let (numbersSignal, numbersObserver) = Signal<String, NoError>.pipe()
    let (signal, observer) = Signal<Signal<String, NoError>, NoError>.pipe()

    signal.flatten(.merge).observeValues { print($0) }

    observer.send(value: lettersSignal)
    observer.send(value: numbersSignal)
    observer.sendCompleted()

    lettersObserver.send(value: "a")    // prints "a"
    numbersObserver.send(value: "1")    // prints "1"
    lettersObserver.send(value: "b")    // prints "b"
    numbersObserver.send(value: "2")    // prints "2"
    lettersObserver.send(value: "c")    // prints "c"
    numbersObserver.send(value: "3")    // prints "3"
}

scopedExample("flatten.latest") {
    let (lettersSignal, lettersObserver) = Signal<String, NoError>.pipe()
    let (numbersSignal, numbersObserver) = Signal<String, NoError>.pipe()
    let (signal, observer) = Signal<Signal<String, NoError>, NoError>.pipe()

    signal.flatten(.latest).observeValues { print($0) }

    observer.send(value: lettersSignal) // nothing printed
    numbersObserver.send(value: "1")    // nothing printed
    lettersObserver.send(value: "a")    // prints "a"
    lettersObserver.send(value: "b")    // prints "b"
    numbersObserver.send(value: "2")    // nothing printed
    observer.send(value: numbersSignal) // nothing printed
    lettersObserver.send(value: "c")    // nothing printed
    numbersObserver.send(value: "3")    // prints "3"
}

scopedExample("flatten.concat") {
    let (lettersSignal, lettersObserver) = Signal<String, NoError>.pipe()
    let (numbersSignal, numbersObserver) = Signal<String, NoError>.pipe()
    let (signal, observer) = Signal<Signal<String, NoError>, NoError>.pipe()

    signal.flatten(.concat).observeValues { print($0) }

    observer.send(value: lettersSignal)
    observer.send(value: numbersSignal)

    lettersObserver.send(value: "a")    // prints "a"
    numbersObserver.send(value: "1")    // nothing printed
    lettersObserver.send(value: "b")    // prints "b"
    numbersObserver.send(value: "2")    // nothing printed
    lettersObserver.send(value: "c")    // prints "c"
    lettersObserver.sendCompleted()     // nothing printed
    numbersObserver.send(value: "3")    // prints "3"
    numbersObserver.sendCompleted()     // nothing printed
}
