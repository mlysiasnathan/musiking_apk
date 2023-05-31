import 'package:flutter/material.dart';

class CustomRouteAnimation<T> extends MaterialPageRoute<T> {
  CustomRouteAnimation({
    required super.builder,
  }) : super(settings: null);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    // if (settings.isInitialRoute) {
    //   return child;
    // }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
