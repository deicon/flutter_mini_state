import 'package:flutter/widgets.dart';

abstract class StateHolder<STATE, SERVICE extends Object>
    extends ValueNotifier<STATE> {
  StateHolder(STATE value) : super(value);
  void setState(STATE value);
  STATE getState();
  SERVICE getService();
}
