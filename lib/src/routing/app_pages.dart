import 'package:flutter/material.dart';
import 'package:tanked/src/presentation/views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.onboarding;

  static final routes = <String, WidgetBuilder>{
    ///Onboarding route
    Routes.onboarding: (_) => const OnboardingView(),
    //Onboarding route

    ///Config routes
    //Identify System route
    Routes.identifySystem: (_) => const IdentifySystemView(),

    //Configure System route
    Routes.configureSystem: (_) => const ConfigureSystemView(),

    //Success Page
    Routes.successfullyConfiguredSystem: (_) =>
        const SuccessfullyConfiguredSystemView(),
    //Config routes

    ///Home route
    Routes.home: (_) => const HomeView(),
    //Home route
  };
}
