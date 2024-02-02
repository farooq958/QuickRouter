import 'package:flutter/widgets.dart';

///[QuickRouterTransitions] is a class providing quick implementations of
///various transition animations for routing between screens.
///
/// The [_transitionRoute] function is a generic helper function creating
/// a [PageRouteBuilder] with a specified transition builder.
///
/// Each transition method (slide, rotation, scale, size, fade) uses
/// [_transitionRoute] and provides a specific transition builder for the
/// desired animation effect.
///
class QuickRouterTransitions<T> {
  // Class that provides quick implementations of various transition animations for routing between screens.

  // Generic function to create a PageRouteBuilder with a specified transition builder
  static PageRouteBuilder<T> _transitionRoute<T>(
    Widget child,
    Widget Function(Animation<double> animation) transitionBuilder,
  ) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        currentChild,
      ) {
        // Invoke the specified transition builder
        return transitionBuilder(animation);
      },
    );
  }

  // Slide transition
  static PageRouteBuilder<T> slide<T>(Widget child) {
    return _transitionRoute<T>(
      child,
      (animation) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  // Rotation transition
  static PageRouteBuilder<T> rotation<T>(Widget child) {
    return _transitionRoute<T>(
      child,
      (animation) => RotationTransition(
        turns: Tween<double>(begin: 0, end: 1).animate(animation),
        child: child,
      ),
    );
  }

  // Scale transition
  static PageRouteBuilder<T> scale<T>(Widget child) {
    return _transitionRoute<T>(
      child,
      (animation) => ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(animation),
        child: child,
      ),
    );
  }

  // Size transition
  static PageRouteBuilder<T> size<T>(Widget child) {
    return _transitionRoute<T>(
      child,
      (animation) => SizeTransition(
        sizeFactor: Tween<double>(begin: 0, end: 1).animate(animation),
        child: child,
      ),
    );
  }

  // Fade transition
  static PageRouteBuilder<T> fade<T>(Widget child) {
    return _transitionRoute<T>(
      child,
      (animation) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: child,
      ),
    );
  }
}
