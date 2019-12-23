import UIKit
import AHFramework
import PlaygroundSupport
import Combine

//let vc = StaticTableViewController()
//PlaygroundPage.current.liveView = vc



/// ***********************************
/// - 1 -
/// ***********************************
let publisher = Just("Hello")
let subscriber = publisher.sink { value in
    print("Just: \(value)")
}



/// ***********************************
/// - 2 -
/// ***********************************
let notifPublisher = NotificationCenter.default.publisher(for: Notification.Name(rawValue: "Test"))
let subscriber1 = notifPublisher.sink { value in
    print("NotificationCenter: \(value)")
}
NotificationCenter.default.post(name: Notification.Name(rawValue: "Test"), object: "Hello")



/// ***********************************
/// - 3 -
/// ***********************************
let passthroughSubject = PassthroughSubject<String, Never>()
let subscriber2 = passthroughSubject.sink { value in
    print("PassthroughSubject: \(value)")
}
passthroughSubject.send("Hello")
passthroughSubject.send("Word")



/// ***********************************
/// - 4 -
/// ***********************************
let currentValueSubject = CurrentValueSubject<String, Never>("Hello")
let subscriber3 = currentValueSubject.sink { value in
    print("CurrentValueSubject: \(value)")
}
currentValueSubject.send("Word")

