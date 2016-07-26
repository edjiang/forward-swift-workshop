# Forward Swift Workshop

This is the GitHub repo for the Forward Swift workshop presented by [Edward Jiang](https://twitter.com/edwardstarcraft).

Time spent preparing for this is sponsored by [Stormpath](https://stormpath.com/), a company that builds developer tools for authentication, user management, and authorization. 

# Lesson Plan

* Swift - the Crash Course (1.5 hours)
 * Basic Types
 * Collections
 * Control Flow & Operators
 * Functions
 * Classes
 * Protocols
 * Extensions
 * Optionals
* Xcode and UIKit - Building a basic app (1.5 hours)
 * Intro to Interface Builder
 * Subclassing a UIViewController and adding @IBOutlets and @IBActions
 * Performing a view transition
 * UINavigationViewController
 * UITableViewController
 * NSLayoutConstraints
* Working with external APIs (30 mins)
 * Basics of a HTTP API
 * Using Postman to test a REST API
 * SwiftNotes API
* Using external SDKs (30 mins)
 * Introduction to CocoaPods
 * Install CocoaPods
 * Install Stormpath SDK
* Build SwiftNotes (2 hours)
 * Implement Login / Registration Screens
 * Implement Notes List View
 * Implement Notes Editing View

# Swift - The Crash Course

Swift is a statically typed, compiled, protocol-oriented language that is compatible with Objective-C. It features C-style syntax that aims to be simple, easy to learn, yet expressive. 

Swift is a constantly evolving language, and what you're seeing here is Swift 2. Swift 3 will make major changes to naming APIs, additional language features and refinements, but the basic things you learn here will be the same. 

For the full Swift reference, check out [Apple's guide](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html), which is fairly straightforward. The [Swift 3 migration guide](https://swift.org/migration-guide/) also discusses the changes that will be made in Swift 3. 

This is a crash course in Swift intended for existing programmers unfamiliar with Swift. 

## Variables

In Swift, you can declare variables. Variables can store basic types as you might expect: 

```Swift
var helloWorld = "Hello, world!" // String
var number = 5 // Int
var decimal = 2.47 // Double
var workshopIsAwesome = true // Bool
```

The variable type is inferred, but sometimes you want to be more specific. You can use colons to define the explicit type:

```Swift
var helloWorld: String = "Hello, world!" // String
var number: Int = 5 // Int
var decimal: Double = 2.47 // Double
var workshopIsAwesome: Bool = true // Bool
```

Swift also has constants. Unlike some other languages, constants are actually a preferred way of dealing with values: 

```Swift
let helloWorld = "Hello, world!" // String
let number = 5 // Int
let decimal = 2.47 // Double
let workshopIsAwesome = true // Bool
```

You can't change a constant:

```Swift
var greeting = "Hi, workshop attendees!"
greeting = "You are late to the workshop 😡"

let workshopTime = "9:30 AM"
workshopTime = "10:00 AM" // ERROR
```

## Collections

Swift also has arrays and dictionaries. 

```Swift
let numbers = [1, 5, 3, 7]
let companies = ["AAPL": "Apple",
                 "MSFT": "Microsoft"]
```

Accessing an element uses standard `[]` syntax:

```Swift
numbers[2] // returns 3
companies["AAPL"] // returns "Apple"
```

Since Swift is strongly typed, it tries to figure out what you're creating using the literal, or you have to initialize the array/dictionary properly:

```Swift
let numbers = [Int]()
let companies = [String: String]()
```

Collections defined as a constant are immutable:

```Swift
let numbers = [1, 5, 3, 7]

numbers.append(5) // ERROR
```

But as a variable are mutable:

```Swift
var numbers = [1, 5, 3, 7]

numbers.append(5) // numbers is now [1, 5, 3, 7, 5]

companies["TWLO"] = "Twilio"
```

## Control Flow

The standard loop is in a for...in pattern:

```Swift
for number in numbers {
    print(number)
}
for (ticker, company) in companies {
    print(ticker)
    print(company)
}
```

Or, you can do a traditional counting loop like this: 

```Swift
for i in 1...10 {
    print(i)
}
```

If statements look very similar: 

```Swift
if i == 3 {
    print("Fizz")
}
```

Swift uses standard C-style symbols and operator ordering for logic:

```Swift
if !(i % 3 == 0) {
    print("I have no idea what just happened")
}
```

## Functions

Functions are first class types in Swift that encapsulate some code. 

Here's a basic function:

```Swift
func sayHello() {
    print("Hello!")
}

sayHello() // Will call above function
```

Arguments use standard variable syntax, and return values are specified by the arrow operator `->`:

```Swift
func add(firstNumber: Int, secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}
```

Swift uses named parameters, meaning that calling a function with parameters will look slightly different:

```Swift
add(3, secondNumber: 5) // Will return 8
```

*Note: the missing named parameter for the `firstNumber` is intentional, and a side effect of an Objective-C convention. In Swift 3, Objective-C APIs will be renamed, and the first parameter will also be named by default, resulting in: `add(firstNumber: 3, secondNumber: 5)`*

Because a function is first-class, it can be saved as a variable, or passed as a parameter:

```Swift
func add(firstNumber: Int, secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}

let adder = add // This has a type signature of (Int, Int) -> Int

adder(3, secondNumber: 5) // Will return 8
```

## Classes

Swift also has objects:

```Swift
class Vehicle {
    var position = 0

    func go(distance: Int) {
        position += distance
    }
}
```

Using an object is simple:

```Swift
let myVehicle = Vehicle()

myVehicle.go(5)
```

By default, Swift will make an `init()` function that does nothing, but you can create your own initializers:

```Swift
class Vehicle {
    var position: Int

    init(position: Int) {
        self.position = position
    }

    func go(distance: Int) {
        position += distance
    }
}

let myVehicle = Vehicle(position: 5)
```

*Note: you may notice that the initializer parameter labels are inconsistient with how functions work. This is indeed correct, and as mentioned earlier, method labels will be fixed in Swift 3. *

Classes can inherit from other objects:

```Swift
class Car: Vehicle {
    override func go(distance: Int) {
        if distance > 300 {
            print("That's too far for me to go!")
        } else {
            super.go(distance)
        }
    }
}
```

## Protocols

Swift also has protocols:

```Swift
protocol Resettable {
    func reset()
}

protocol HasHorn {
    func honk()
}
```

Objects can implement these protcols:

```Swift
class Car: Vehicle, Resettable {
    override func go(distance: Int) {
        if distance > 300 {
            print("That's too far for me to go!")
        } else {
            super.go(distance)
        }
    }

    func honk() {
        print("BEEP!")
    }
}
```

Alternatively, protocols can implement its own functionality: 

```Swift
extension HasHorn {
    func honk() {
        print("BEEP!")
    }
}

extension Vehicle: Resettable {
    func reset() {
        position = 0
    }
}
```

## Optionals

One of the coolest features of Swift are the optionals. In many languages, only objects can be `null`, while basic value types like Ints cannot be null. This leads to inconsistient behavior at times. Also, a lot of your code may look like:

```
if (object != null && object.subProperty != null && object.subProperty.anotherProperty != null) {
    object.subProperty.anotherProperty.method()
}
```

Swift deals with this using optionals, which allow you to deal with `nil` in a predictable way. Also, basic value types can be `nil`. 

You can define an optional type using the `?` operator:

```Swift
var vehicle: Vehicle = Vehicle()
var optionalVehicle: Vehicle? = Vehicle()
var nilVehicle: Vehicle? = nil
```

You can call a method on an optional, and not worry about it being null using the `?` operator. If it's nil, the operation doesn't do anything: 

```Swift
optionalVehicle?.honk()
nilVehicle?.honk()
```

This is useful when you need to chain optionals:

```Swift
let temperature = optionalVehicle?.engine?.temperature
// Temperature would be an optional 
```

## Unwrapping Optionals

When you don't want an optional, there are several strategies you can use. The first is the `if let` command:

```Swift
let number: Int? = 5

if let number = number {
    // number is no longer an optional
    print(number)
}
```

In Swift, the convention is to create a new (locally scoped) variable named the same thing as the original variable, to be clear what you're doing. 

Swift also has the `guard` operator, which is like `if` but forces exit of the current block scope:

```Swift
guard let number = number else {
    return
}

print(number)
```

You can also use the nil coalescing operator to provide a default value for an optional:

```Swift
print(number ?? 0) // Shorthand for if number == nil, number = 0
```

## Force Unwrapped / Implicitly Unwrapped Optionals

In some cases, there are instances where the variable needs to be declared as an optional, but in practice will NEVER be optional. In that case, you can use the `!` operator. The ! operator will crash your program if misused, so use it carefully!

In most cases, you will use this against Objective-C APIs that are unclear about optionality, or where an object takes user input that you are *sure* is valid. 

```Swift
let url = URL(string: "http://google.com/")!
let text = textField.text!
```

In this example, a URL can be optional since we may not pass in a valid URL string. But since we know it's a valid URL, we'll force unwrap it with the `!` operator. Similarly, `textField` is valid, but it's `text` property returns an optional since it's a legacy Objective-C API. In this case, we know it will never be null, so we're comfortable force unwrapping this optional. 

You can also use the `!` operator in type definition. In this case, this is called an "implicitly unwrapped optional".

```Swift
let firstNumber: Int! = nil
firstNumber = 5
```

In general, this operates like null variables in other languages, and will crash your program if you attempt to use a nil. Use this feature sparingly; usually the main use case for implicitly unwrapped optionals are in objects that use external frameworks to inject dependencies:

```Swift
class CustomViewController: UIViewController {
    var apiClient: APIClient!
    var textField: UITextField!
}

let viewController = CustomViewController()
viewController.apiClient = APIClient.sharedSession()
viewController.textFIeld = textField

showViewController(viewController, sender: self)
```

Congrats for making it through the Swift crash course! Now you should be ready to start learning more about Xcode and the UIKit APIs =]

# Further Reading

* [Ray Wenderlich](https://www.raywenderlich.com) - Tutorial site
* [NSHipster](http://nshipster.com/) - Articles on interesting iOS topics
* [iOS Programming - The Big Nerd Ranch Guide](http://amzn.to/2asPBvv) - The best book on iOS introduction stuff. Period. 