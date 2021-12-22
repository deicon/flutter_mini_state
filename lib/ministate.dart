library ministate;

import 'package:get_it/get_it.dart';

export 'state/state.dart';
export 'widget/widget.dart';

// Register Service Instance and Stateholder Instance as
// Singletons using get_it service locator
void registerState<STATEHOLDER extends Object, SERVICE extends Object>(
    STATEHOLDER stateholder, SERVICE service) {
  GetIt.instance.registerSingleton<STATEHOLDER>(stateholder);
  GetIt.instance.registerSingleton<SERVICE>(service);
}

// simplified acces to STATEHOLDER instance from get_it
STATEHOLDER stateHolder<STATEHOLDER extends Object>() {
  return GetIt.instance.get<STATEHOLDER>();
}
