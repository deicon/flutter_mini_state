import 'package:get_it/get_it.dart';
import 'package:ministate/state/state_holder.dart';

class DefaultStateHolder<STATE, SERVICE extends Object>
    extends StateHolder<STATE, SERVICE> {
  DefaultStateHolder(STATE value) : super(value);

  @override
  void setState(STATE value) {
    this.value = value;
    notifyListeners();
  }

  @override
  SERVICE getService() {
    // locator Pattern. This assumes a service of type SERVICE
    // is registered in Getit somewhere
    return GetIt.instance<SERVICE>();
  }

  @override
  STATE getState() {
    return value;
  }
}
