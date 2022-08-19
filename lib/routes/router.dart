import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stedom/routes/routes.dart';
import 'package:stedom/screens/authentication/login_screen.dart';
import 'package:stedom/screens/authentication/registration_screen.dart';
import 'package:stedom/screens/home/walk_through.dart';
import 'package:stedom/screens/home/welcome_screen.dart';
import 'package:stedom/screens/root.dart';
import 'package:stedom/screens/test.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case walkThroughViewRoute:
      return PageTransition(
        child: const WalkThroughScreen(),
        type: PageTransitionType.fade,
      );

    case welcomeViewRoute:
      return PageTransition(
        child: const WelcomeScreen(),
        type: PageTransitionType.fade,
      );

    case homeViewRoute:
      return PageTransition(
        child: const Root(),
        type: PageTransitionType.fade,
      );

    case loginViewRoute:
      return PageTransition(
        child: const LoginScreen(),
        type: PageTransitionType.fade,
      );

    case registrationViewRoute:
      return PageTransition(
        child: const RegistrationScreen(),
        type: PageTransitionType.fade,
      );

    case testViewRoute:
      return PageTransition(
        child: const TestScreen(),
        type: PageTransitionType.fade,
      );

    default:
      return PageTransition(
        child: const TestScreen(),
        type: PageTransitionType.fade,
      );
  }
}
