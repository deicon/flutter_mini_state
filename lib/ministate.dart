library ministate;

import 'package:get_it/get_it.dart';

export 'state/state.dart';
export 'widget/widget.dart';

void registerState<STATEHOLDER extends Object, SERVICE extends Object>(
    STATEHOLDER stateholder, SERVICE service) {
  GetIt.instance.registerSingleton<STATEHOLDER>(stateholder);
  GetIt.instance.registerSingleton<SERVICE>(service);
}

STATEHOLDER stateHolder<STATEHOLDER extends Object>() {
  return GetIt.instance.get<STATEHOLDER>();
}
