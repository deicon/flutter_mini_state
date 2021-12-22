import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ministate/ministate.dart';
import 'package:ministate/state/getit_state_holder.dart';

// create Some State
class SomeState extends Equatable {
  final int counter;

  const SomeState(this.counter);
  @override
  List<Object?> get props => [counter];
}

// Some class used as Service it needed
class BackendService {
  void saveState(SomeState state) {
    // magically save state in some storage
  }

  Future<SomeState> retrieveLastState() async {
    return const SomeState(0);
  }
}

// Define the StateHolder and derive from GetItStateHolder
class CounterStateHolder extends DefaultStateHolder<SomeState, BackendService> {
  CounterStateHolder(SomeState value) : super(value);

  // define mutation methods
  void increment() {
    // create new state derive from old value/state
    // calling setState triggers re rendering
    var nextState = SomeState(value.counter + 1);
    // using backendService to save State somewhere
    getService().saveState(nextState);
    setState(nextState);
  }

  void decrement() {
    // create new state derive from old value/state
    // calling setState triggers re rendering
    setState(SomeState(value.counter - 1));
  }
}

void main() {
  // register all StateHolders and their needed Services before
  // Start of the App
  registerState(CounterStateHolder(const SomeState(0)), BackendService());
  // and finally run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Minimalist State Mangagement'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  void _incrementCounter() {
    // freely access the state holder anywhere using GetIt Locator
    stateHolder<CounterStateHolder>().increment();
  }

  @override
  Widget build(BuildContext context) {
    var stateholder = stateHolder<CounterStateHolder>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // make sure the state triggers rendering once changed
            // by using the MiniStateBuilder
            MiniStateBuilder<CounterStateHolder, SomeState>(
                listener: (context, value) {
              // react here on specific states just before rendering the
              // new state
              if (value.counter == 10) {
                // reset by explicitly setting states value
                // told ya. minimalistic approach.
                stateholder.setState(const SomeState(0));
              }
            }, builder: (ctx, value, stateHolder, child) {
              return Text(
                '${value.counter}',
                style: Theme.of(context).textTheme.headline4,
              );
            })
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            stateholder.decrement();
          },
          child: const Text("-"),
        ),
        ElevatedButton(
          onPressed: () {
            stateholder.increment();
          },
          child: const Text("+"),
        ),
      ],
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
