import 'package:get_it/get_it.dart';
import 'package:ministate/state/state_holder.dart';

// Default StateHolder implementation
// responsible to hold a STATE as well as knowing
// the type of a backend service.
//
// STATE can be any kind of simple or complex state class
// SERVICE can be any class responsible for Backend communication
// or generally speaking beeing the data layer of the state manager
class DefaultStateHolder<STATE, SERVICE extends Object>
    extends StateHolder<STATE, SERVICE> {
  // Ctor taking a STATE [value] instance
  DefaultStateHolder(STATE value) : super(value);

  // Setting a new STATE [value] instance, overriding the last state if different
  // and notifying all listeners of the new state
  @override
  void setState(STATE value) {
    this.value = value;
    notifyListeners();
  }

  // Retrieving the registered get_it singleton of the known
  // SERVICE Type.
  @override
  SERVICE getService() {
    // locator Pattern. This assumes a service of type SERVICE
    // is registered in Getit somewhere
    return GetIt.instance<SERVICE>();
  }

  // Retrieve current STATE of the StateHolder
  @override
  STATE getState() {
    return value;
  }
}
