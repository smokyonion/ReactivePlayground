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

scopedExample("concat") {

    let number = numberProperty
    let letter = letterProperty

    number.map { "\($0)" }.producer.concat(letter.producer).scan(0) { count, value -> Int in
        print("value: ", value)
        return count + 1
        }.startWithValues { print("count: ", $0) }
    
}