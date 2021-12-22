<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A Minimalistic approach to State Management in Flutter. 
This is inspired by [State Management for Minimalists](https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1)
and tries to put this idea into a reusable component. 

## Features

Simple State Management based on 
 * Service Locator Pattern using [Get it](https://pub.dev/packages/get_it)
 * Custom State classes using [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)
 * Custom MiniStateBuilder based on [ValueListenableBuilder](https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html)


## Getting started

### Create some State class
The state class will be holding some or even all
of the apps state. In order to distinguish new from old states, make sure states can be compared 
for equality. 

````dart
class SomeState extends Equatable {
  final int counter;

  const SomeState(this.counter);
  @override
  List<Object?> get props => [counter];
}
````

### Define a StateHolder and Service
To separate logic, state and persistence, each State will be handled by a StateHolder class which in turn knows which Service to use for Persistence. 

So first define a Service class. This should be the place to talk to backend services or do local 
persistence on the device. 

```dart
class BackendService {}
```

Then the StateHolder class to bind it all together. StateHolder class is derived from _DefaultStateHolder_ and 
typed with the _StateClass_ as well as the _Service_ classname.

Stateholder 

1. holds the state
2. provides mutation methods to be used anywhere
3. knows how to notify rendering widgets of changes

```dart
class CounterStateHolder extends DefaultStateHolder<SomeState, BackendService> {
  CounterStateHolder(SomeState value) : super(value);

  // define mutation methods
  void increment() {
    // create new state derive from old value/state
    // calling setState triggers re rendering
    setState(SomeState(value.counter + 1));
  }

  void decrement() {
    // create new state derive from old value/state
    // calling setState triggers re rendering
    setState(SomeState(value.counter - 1));
  }
}
```

## Usage
Once all needed classes are set up, make sure to 
register all _StateHolder_ with their _Serives_ at start of 
the main app. 

```dart 

void main() {
  // register all StateHolders and their needed Services before
  // Start of the App
  registerState(CounterStateHolder(const SomeState(0)), BackendService());

  // and finally run the app
  runApp(const MyApp());
}
```

To display states and react on state changes use 

```dart
// access Stateholder anywhere in the code 
// using provided stateHolder<> method
var stateholder = stateHolder<CounterStateHolder>();
...
MiniStateBuilder<CounterStateHolder, Counter>(
        listener: (context, value) {
            // react here on specific states just before rendering the
            // new state
            if (value.counter == 10) {
                // reset by explicitly setting states value
                // told ya. minimalistic approach.
                stateholder.setState(const SomeState(0));
            }
        }, 
        builder: (ctx, value, stateHolder, child) {
            return Text(
            '${value.counter}',
            style: Theme.of(context).textTheme.headline4,
            );
        })
...
```

As the _StateHolder_ is available anywhere using LocatorPattern, one can simply use it in any action handler to mutate state. 

```dart
ElevatedButton(
    onPressed: () {
    stateHolder<CounterStateHolder>().decrement();
    },
    child: const Text("-"),
),
```
