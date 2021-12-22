import 'package:flutter/widgets.dart';

// Each StateHolder keeps exactly one STATE value
// and knows the type of the relevant backend SERVICE
abstract class StateHolder<STATE, SERVICE extends Object>
    extends ValueNotifier<STATE> {
  StateHolder(STATE value) : super(value);
  // setting a new STATE [value]
  void setState(STATE value);

  // Retrieving the current STATE
  STATE getState();

  // Locate backend SERVICE
  SERVICE getService();
}
