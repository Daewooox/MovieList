# MovieList

## Architecture
I chose MVVM + C for the architectural pattern based on my experience with most projects, I prefer to use this pattern.
From MVVM perspective, view controller is only responsible for altering views and passing view inputs to the view model. Consequently, you’ll remove any other logic from the view controller and move it to the view model.
For bindings in MVVM I used RxSwift because it more elegant solution for this approach.
And Coordinators are a great tool because they free our ViewController’s from a responsibility that they should not have. This helps us adhere to the single responsibility principle, which makes our ViewController’s much cleaner and easier to reuse.

##Binding and data passing
For data communication I chose RxSwift/RxCocoa because that's good library for working with asynchronous code that presents events as streams of events with the ability to subscribe to them, and also allows you to apply functional programming approaches to them, which greatly simplifies working with complex sequences of asynchronous events.

## Networking 
Moya+RxSwift because Moya is a good networking library inspired by the concept of encapsulating network requests in type-safe way, typically using enumerations, that provides confidence when working with your network layer. 

## Routing
For Coordinators pattern pattern I used XCoordinator framework. Good templates for using this pattern.

## Images download
SDWebImage pretty usefull library that's provides an async image downloader with cache support.

## Code style & Utills
I chose SwiftLint for code style because enforces the style guide rules that are generally accepted by the Swift community.
R.swift for autocompleted resources.

## Area of improvements 
* Network service can be refactored flexible and moduled. Moya framework provide good possibility to setup network layer and it can be scalable.
* Coverage necessary modules with tests
* Use tepmplates generator for architectural pattern
