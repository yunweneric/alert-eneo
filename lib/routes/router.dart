import 'package:eneo_fails/app/home/widgets/home_layout.dart';
import 'package:eneo_fails/app/start/onboarding.dart';
import 'package:eneo_fails/app/start/splash_screen.dart';
import 'package:eneo_fails/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage transitionEffect({required state, required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

//*----------------------------------------------------------------
//*----------------------------------------------------------------

final routes = GoRouter(
  routes: [
    // ** Splash screen routes
    GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            transitionEffect(state: state, child: SplashScreen())),
    GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) =>
            transitionEffect(state: state, child: HomeLayout())),
    GoRoute(
        path: AppRoutes.start,
        pageBuilder: (context, state) =>
            transitionEffect(state: state, child: OnboardingScreen())),
  ],
);
