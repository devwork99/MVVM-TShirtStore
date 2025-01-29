//
//  Notes.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 27/01/2025.
//

import Foundation

/*

 What are types of Design patterns?
 
 
1. Creational Patterns (Object Creation)
🔹 Singleton
Ensures a class has only one instance and provides a global access point.
Used for shared resources like UserDefaults, URLSession, and CoreData stack.
            Example:
                swift
            Copy
            Edit
            class NetworkManager {
    static let shared = NetworkManager()
    private init() {} // Prevents instantiation
}
2. Structural Patterns (Class/Object Composition)
🔹 MVC (Model-View-Controller)
Apple's recommended pattern but often criticized for leading to massive view controllers.
                                                        Model: Handles data and business logic.
                                                        View: UI elements.
                                                        Controller: Mediates between Model and View.
                                                        Example:
                                                            swift
                                                        Copy
                                                        Edit
                                                        class UserModel {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class UserViewController: UIViewController {
    var user: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user?.name ?? "No User")
    }
}
🔹 MVVM (Model-View-ViewModel)
Improves testability and separation of concerns.
ViewModel acts as an intermediary between Model and View.
Often used with Combine or RxSwift for binding.
                                        Example:
                                            swift
                                        Copy
                                        Edit
                                        class UserViewModel {
    var userName: String
    init(user: UserModel) {
        self.userName = user.name
    }
}

class UserViewController: UIViewController {
    var viewModel: UserViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel?.userName ?? "No User")
    }
}
🔹 Coordinator
Used for navigation management instead of tightly coupling it to ViewControllers.
            Example:
                swift
            Copy
            Edit
            protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = HomeViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
3. Behavioral Patterns (Object Interaction)
🔹 Observer (Used in Combine, NotificationCenter, KVO)
Enables one-to-many dependency between objects.
Example using Combine:
swift
Copy
Edit
class UserViewModel {
    @Published var name: String = "John"
}

let viewModel = UserViewModel()
let cancellable = viewModel.$name.sink { newName in
    print("User changed name to \(newName)")
}
viewModel.name = "Alice"  // Triggers observer
🔹 Delegate (Common in UIKit)
A class delegates work to another class via a protocol.
Example:
swift
Copy
Edit
protocol UserDelegate: AnyObject {
    func didUpdateUser(name: String)
}

class User {
    weak var delegate: UserDelegate?
    func updateName(newName: String) {
        delegate?.didUpdateUser(name: newName)
    }
}

class ViewController: UIViewController, UserDelegate {
    func didUpdateUser(name: String) {
        print("Updated user name to \(name)")
    }
}
🔹 Factory Pattern
Used for encapsulating object creation.
            Example:
                swift
            Copy
            Edit
            protocol Button {
    func render()
}

class iOSButton: Button {
    func render() { print("Rendering iOS Button") }
}

class ButtonFactory {
    static func createButton() -> Button {
        return iOSButton()
    }
}

let button = ButtonFactory.createButton()
button.render()
Other Notable Design Patterns
Facade: Simplifies a complex system by providing a unified interface.
Dependency Injection: Passes dependencies instead of creating them inside a class.
State: Allows an object to change its behavior based on internal state.
Strategy: Encapsulates interchangeable behaviors in separate classes.
 
//================================================================================
 
 what are some of the anti patterns that are used by junior developers that you have noticed, and how you have corrected them?
 
 That’s a great interview question! It tests both your experience mentoring junior developers and your awareness of coding best practices. Here are some common anti-patterns I’ve noticed in junior iOS developers' code and how I’ve helped them correct these issues:

 ### **1. Massive View Controller (MVC Anti-Pattern)**
    - **Issue**: Many juniors put too much logic in ViewControllers, making them bloated and hard to maintain.
    - **Correction**: I encourage breaking logic into separate layers using MVVM, Coordinator, or even simple helper classes.

 ### **2. Hardcoded Strings and Magic Numbers**
    - **Issue**: Defining UI strings, API URLs, and layout constraints directly in code.
    - **Correction**: I suggest using `NSLocalizedString` for localization, `Constants` struct for app-wide values, and `UIFontMetrics` for scalable fonts.

 ### **3. Force Unwrapping (`!`) and Unsafe Optionals**
    - **Issue**: Overusing force unwrap (`!`) leads to crashes.
    - **Correction**: I teach using `if let`, `guard let`, or default values to safely unwrap optionals.

 ### **4. Not Using Weak References in Closures (`retain cycles`)**
    - **Issue**: Forgetting to use `[weak self]` in closures leading to memory leaks.
    - **Correction**: I guide them to always consider capture lists in closures and explain how retain cycles happen.

 ### **5. Blocking the Main Thread**
    - **Issue**: Performing heavy computations or network calls on the main thread, causing UI lag.
    - **Correction**: I stress using `DispatchQueue.global(qos: .background)` for background tasks and switching back to the main thread for UI updates.

 ### **6. Poor Use of Auto Layout (e.g., Ambiguous Constraints)**
    - **Issue**: Adding unnecessary constraints or not handling safe area insets properly.
    - **Correction**: I recommend using `NSLayoutConstraint.activate([])` or leveraging SwiftUI for easier UI handling.

 ### **7. Overuse of Singletons**
    - **Issue**: Using singletons everywhere instead of dependency injection.
    - **Correction**: I explain how singletons create hidden dependencies and suggest dependency injection using constructors or protocols.

 ### **8. Lack of Unit Tests**
    - **Issue**: Writing code without considering testability.
    - **Correction**: I encourage writing testable code with protocols and dependency injection, making unit testing easier.

 ### **9. Ignoring Accessibility**
    - **Issue**: Not considering VoiceOver, dynamic text, or color contrast.
    - **Correction**: I introduce accessibility APIs and show how small changes improve usability.

 ### **10. Poor Error Handling**
    - **Issue**: Using `try!` or ignoring errors from API responses.
    - **Correction**: I recommend structured error handling with `do-catch`, custom error enums, and logging for debugging.

 Would you like to refine your answer for future interviews? Maybe tailor it to your experience? 🚀
 
 
*/
