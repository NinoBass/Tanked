part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const onboarding = _Paths.onboarding;
  static const configureSystem = _Paths.configureSystem;
  static const identifySystem = _Paths.identifySystem;
  static const successfullyConfiguredSystem =
      _Paths.successfullyConfiguredSystem;
}

abstract class _Paths {
  static const home = '/home';
  static const configureSystem = '/configure-system';
  static const successfullyConfiguredSystem = '/successfully-configured-system';
  static const identifySystem = '/identify-system';
  static const onboarding = '/onboarding';
}
