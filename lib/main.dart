import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tanked/firebase_options.dart';
import 'package:tanked/src/presentation/themes/app.themes.dart';
import 'package:tanked/src/routing/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Initalize widgets binding
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  GetStorage.init();

  runApp(
    const Tanked(),
  );
}

class Tanked extends StatelessWidget {
  const Tanked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        initialRoute: Routes.onboarding,
        routes: AppPages.routes,
        debugShowCheckedModeBanner: false,
        title: 'Tanked',
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: AppThemes().getThemeMode(),
        supportedLocales: const [
          Locale('en'),
        ],
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
        ],
      ),
    );
  }
}
