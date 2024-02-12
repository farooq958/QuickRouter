// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_router_transitions.dart';

/// An extension that provides some handy methods for navigating between routes
/// using the Navigator widget. It supports both regular and restorable routes,
/// as well as different transition types.
extension QuickRouter on BuildContext {
  /// A method that pushes a new route to the Navigator with the given child widget
  /// and transition type.

  Future<T?> to<T extends Object?>(
    Widget child, {
    QuickTransition transitions = QuickTransition.Fade,
  }) {
    return Navigator.of(this).push(_transit(child, transitions));
  }

  /// A method that pops the current route and returns an optional result to the
  /// previous route.
  void back<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// A method that pushes a new route to the Navigator with the given child widget
  /// and transition type, and replaces the current route with the new one.
  /// It also returns an optional result to the previous route.
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Widget child,
      {QuickTransition transitions = QuickTransition.Fade,
      TO? result}) {
    return Navigator.of(this)
        .pushReplacement<T, TO>(_transit(child, transitions), result: result);
  }

  /// A method that pushes a new route to the Navigator with the given child widget
  /// and transition type, and removes all the previous routes until the predicate
  /// is satisfied.
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget child,
    RoutePredicate predicate, {
    QuickTransition transitions = QuickTransition.Fade,
  }) {
    return Navigator.of(this)
        .pushAndRemoveUntil<T>(_transit(child, transitions), predicate);
  }

  /// A method that pushes a new restorable route to the Navigator with the given
  /// route builder and arguments, and removes all the previous routes until the
  /// predicate is satisfied. It returns a restoration ID that can be used to
  /// restore the state of the route.
  String restorablePushAndRemoveUntil<T extends Object?>(
      RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate,
      {Object? arguments}) {
    return Navigator.of(this).restorablePushAndRemoveUntil<T>(
        newRouteBuilder, predicate,
        arguments: arguments);
  }

  /// A method that replaces the current route with a new one with the given child
  /// widget and transition type. It also preserves the type parameter of the
  /// current route.
  @optionalTypeArgs
  void replace<T extends Object?>(
      {required Widget old,
      required Widget to,
      QuickTransition transitions = QuickTransition.Fade}) {
    return Navigator.of(this).replace<T>(
        oldRoute: _transit(old, transitions),
        newRoute: _transit(old, transitions));
  }

  /// A method that replaces the current route with a new restorable route with
  /// the given route builder and arguments. It also preserves the type parameter
  /// of the current route and returns a restoration ID that can be used to
  /// restore the state of the route.
  String restorableReplace<T extends Object?>(
      {required Widget old,
      required RestorableRouteBuilder<T> to,
      QuickTransition transitions = QuickTransition.Fade,
      Object? arguments}) {
    return Navigator.of(this).restorableReplace<T>(
        oldRoute: _transit(old, transitions),
        newRouteBuilder: to,
        arguments: arguments);
  }

  /// A method that replaces the route below the current one with a new one with
  /// the given child widget and transition type. It also preserves the type
  /// parameter of the route below the current one.
  void replaceRouteBelow<T extends Object?>({
    required Widget anchor,
    required Widget to,
    QuickTransition transitions = QuickTransition.Fade,
  }) {
    return Navigator.of(this).replaceRouteBelow<T>(
      anchorRoute: _transit(anchor, transitions),
      newRoute: _transit<T>(to, transitions),
    );
  }

  /// A method that replaces the route below the current one with a new restorable
  /// route with the given route builder and arguments. It also preserves the type
  /// parameter of the route below the current one and returns a restoration ID
  /// that can be used to restore the state of the route.
  String restorableReplaceRouteBelow<T extends Object?>({
    required Widget anchor,
    required RestorableRouteBuilder<T> newRouteBuilder,
    Object? arguments,
    QuickTransition transitions = QuickTransition.Fade,
  }) {
    return Navigator.of(this).restorableReplaceRouteBelow<T>(
        anchorRoute: _transit(anchor, transitions),
        newRouteBuilder: newRouteBuilder,
        arguments: arguments);
  }

  /// A method that returns true if the Navigator can pop the current route.
  bool canPop() {
    final NavigatorState? navigator = Navigator.maybeOf(this);
    return navigator != null && navigator.canPop();
  }

  /// A method that tries to pop the current route and returns a future that
  /// completes with true if the pop succeeded, and false otherwise. It also
  /// returns an optional result to the previous route.
  Future<bool> maybePop<T extends Object?>([T? result]) {
    return Navigator.of(this).maybePop<T>(result);
  }

  /// A method that pops all the routes until the predicate is satisfied.
  void popUntil(bool Function(Route<dynamic> route) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// A method that removes the given route from the Navigator.
  void removeRoute(Route<dynamic> route) {
    return Navigator.of(this).removeRoute(route);
  }

  /// A method that removes the route below the given one from the Navigator.
  void removeRouteBelow(Route<dynamic> anchorRoute) {
    return Navigator.of(this).removeRouteBelow(anchorRoute);
  }
}

PageRouteBuilder<T> _transit<T>(
  Widget child,
  QuickTransition transitions,
) {
  switch (transitions) {
    case QuickTransition.Slide:
      return QuickRouterTransitions.slide<T>(child);
    case QuickTransition.Rotate:
      return QuickRouterTransitions.rotation<T>(child);
    case QuickTransition.Scale:
      return QuickRouterTransitions.scale<T>(child);
    case QuickTransition.Size:
      return QuickRouterTransitions.size<T>(child);
    case QuickTransition.Fade:
      return QuickRouterTransitions.fade<T>(child);
  }
}

/// Enum representing different types of quick transition animations for routing between screens.
enum QuickTransition {
  /// Slide transition: Moving the screen in from the side.
  Slide,

  /// Rotate transition: Rotating the screen during the transition.
  Rotate,

  /// Scale transition: Scaling the screen during the transition.
  Scale,

  /// Size transition: Changing the size of the screen during the transition.
  Size,

  /// Fade transition: Changing the opacity of the screen during the transition.
  Fade,
}
