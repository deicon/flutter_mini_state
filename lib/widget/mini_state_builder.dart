import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ministate/state/state_holder.dart';

typedef StateBuilder<STATEHOLDER extends StateHolder, STATE> = Widget Function(
    BuildContext context, STATE value, STATEHOLDER stateHolder, Widget? child);

typedef StateListener<STATE> = void Function(BuildContext context, STATE value);

// MiniStateBuilder for STATEHOLDER and STATE which
// automatically rebuilds once state changes
class MiniStateBuilder<STATEHOLDER extends StateHolder, STATE>
    extends StatelessWidget {
  final StateBuilder builder;
  final StateListener? listener;

  const MiniStateBuilder({Key? key, required this.builder, this.listener})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GetIt.instance.get<STATEHOLDER>() as dynamic,
        builder: (context, value, child) {
          // call listeners if any defined
          if (listener != null) {
            listener!(context, value);
          }
          return builder(context, GetIt.instance.get<STATEHOLDER>().getState(),
              GetIt.instance.get<STATEHOLDER>(), child);
        });
  }
}
