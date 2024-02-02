

## Features
The `QuickRouter` extension provides handy methods for navigating between routes using the `Navigator` widget in Flutter. It supports both regular and restorable routes and offers various transition types.

## Getting started



### context.to(NewScreen()) : 
This method pushes a new route to the Navigator with the given child widget and transition type. It returns a ```Future<T?>``` that completes when the pushed route is popped off the navigator.

For example: 
```dart
context.to(const SecondScreen())
```
will navigate to the second screen using the default fade transition.


### context.back(result):
 This method pops the current route from the Navigator and returns an optional result. The result can be of any type and it will be passed to the previous route.

  For example:
  ```dart
  context.back('Hello from second')
  ```
will return to the previous screen with the string result.


### context.pushReplacement(child, result) : 
This method pushes a new route to the Navigator with the given child widget and transition type, and replaces the current route with the new one. It also returns an optional result to the previous route. 

For example: 
```dart
context.pushReplacement(const ThirdScreen(), result: 'Hello from home')
```
 will replace the current screen with the third screen and pass the string result to the home screen.


#### context.pushAndRemoveUntil(child, predicate):
 This method pushes a new route to the ```Navigator``` with the given child widget and transition type, and removes all the previous routes until the predicate is satisfied. The predicate is a function that takes a route as an argument and returns a boolean value.
  For example: 
  ```dart
   context.pushAndRemoveUntil(const FourthScreen(), (route) => route.isFirst)
  ```
will remove all the routes except the first one and navigate to the fourth screen.


### context.restorablePushAndRemoveUntil(newRouteBuilder, predicate, arguments): 
This method pushes a new restorable route to the Navigator with the given route builder and arguments, and removes all the previous routes until the predicate is satisfied. It returns a restoration ID that can be used to restore the state of the route. The route builder is a function that takes a context and arguments as arguments and returns a route. 

For example:
 ```dart
 context.restorablePushAndRemoveUntil((context, arguments) => MaterialPageRoute(builder: (context) => const FifthScreen(), settings: const RouteSettings(name: '/fifth')), (route) => false, arguments: 'Some arguments')
 ```
 will remove all the routes and navigate to the fifth screen with restoration and arguments.


### context.replace(old, to): 
This method replaces the current route with a new one with the given child widget and transition type. It also preserves the type parameter of the current route.
 For example: 
 ```
 context.replace(old: this, to: const ThirdScreen())
 ```
  will replace the current screen with the third screen and keep the same result type.


### context.restorableReplace(old, to, arguments):
 This method replaces the current route with a new restorable route with the given route builder and arguments. It also preserves the type parameter of the current route and returns a restoration ID that can be used to restore the state of the route.
  For example:

 ```dart
  context.restorableReplace(old: this, to: (context, arguments) => MaterialPageRoute(builder: (context) => const FifthScreen(), settings: const RouteSettings(name: '/fifth')), arguments: 'Some arguments') 
 ```

  will replace the current screen with the fifth screen with restoration and arguments and keep the same result type.


### context.replaceRouteBelow(anchor, to): 
This method replaces the route below the current one with a new one with the given child widget and transition type. It also preserves the type parameter of the route below the current one.
 For example:
 ```dart 
 context.replaceRouteBelow(anchor: this, to: const FourthScreen())
```
  will replace the route below the current one with the fourth screen and keep the same result type.

# Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

