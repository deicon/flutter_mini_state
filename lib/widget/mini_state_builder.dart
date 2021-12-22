import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

typedef StateBuilder<STATE> = Widget Function(
    BuildContext context, STATE value, Widget? child);

typedef StateListener<STATE> = void Function(BuildContext context, STATE value);

class MiniStateBuilder<STATEHOLDER extends Object, STATE>
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
          return builder(context, value, child);
        });
  }
}
