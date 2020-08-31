import UIKit
import PlaygroundSupport
import Combine

//let vc = StaticTableViewController()
//PlaygroundPage.current.liveView = vc


func example(of name: String, execute: () -> Void) {
    print("——— Example of: \(name) ———")
    execute()
    print()
}

var subscriptions = Set<AnyCancellable>()

/// ***********************************
/// - 1 -
/// ***********************************
example(of: "Just") {
    let publisher = Just("Hello")
    let subscriber = publisher
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
}

example(of: "Array") {
    let publisher = [1, 2, 3].publisher
    let subscriber = publisher
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
}


/// ***********************************
/// - 2 -
/// ***********************************
example(of: "Notification") {
    let notificationName = Notification.Name(rawValue: "Test")
    let publisher = NotificationCenter.default.publisher(for: notificationName)
    let subscriber = publisher
        .sink { value in
            print(value)
        }

    NotificationCenter.default.post(name: notificationName, object: "Hello")
}


/// ***********************************
/// - 3 -
/// ***********************************
example(of: "PassthroughSubject") {
    let subject = PassthroughSubject<String, Never>()
    let subscriber = subject
        .sink { value in
            print(value)
        }

    subject.send("Hello")
    subject.send("Word")
}


/// ***********************************
/// - 4 -
/// ***********************************
example(of: "CurrentValueSubject") {
    let subject = CurrentValueSubject<String, Never>("Hello")
    let subscriber = subject
        .sink { value in
            print(value)
        }

    subject.send("Word")
}


/// ***********************************
/// - 5 -
/// ***********************************
example(of: "Array Publisher Assign") {
    class SomeObject {
        var value: String = "" {
            didSet {
                print(value)
            }
        }
    }

    let object = SomeObject()

    let publisher = ["Hello", "World"].publisher
        let subscriber = publisher
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
}


/// ***********************************
/// - 6 -
/// ***********************************
example(of: "Custom Subscriber") {
    final class IntSubscriber: Subscriber {
        typealias Input = Int
        typealias Failure = Never

        func receive(subscription: Subscription) {
            subscription.request(.max(3))
        }

        func receive(_ input: Int) -> Subscribers.Demand {
            print(input)
            return input == 3 ? .max(1) : .none
//            return .unlimited
        }

        func receive(completion: Subscribers.Completion<Never>) {
            print(completion)
        }
    }

    let subscriber = IntSubscriber()
    let publisher = (1...6).publisher

    publisher.subscribe(subscriber)
    publisher.sink { value in
        print(value)
    }
}


/// ***********************************
/// - 7 -
/// ***********************************
example(of: "Future") {
    func futureIncrement(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
        Future<Int, Never> { promise in
            print("Original")

            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                promise(.success(integer + 1))
            }
        }
    }

    let future = futureIncrement(integer: 1, afterDelay: 3)

    future
        .sink(receiveCompletion: {
            print($0)
        }, receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)

    future
        .sink(receiveCompletion: {
            print("Second", $0)
        }, receiveValue: {
            print("Second", $0)
        })
        .store(in: &subscriptions)
}


