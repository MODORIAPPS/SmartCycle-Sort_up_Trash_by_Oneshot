import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:googleapis/drive/v2.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/ui/main/main_page.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

final supportedLocales = const [
  const Locale('en', 'US'),
  const Locale('ko', "KR"),
  const Locale('ja', "JP"),
  const Locale('zh', "CN"),
];

final localizationsDelegates = <LocalizationsDelegate>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
//        '/cameraStart' : (context) => CameraActvity(),
      },
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocales in supportedLocales) {
          if (supportedLocales.languageCode == locale.languageCode &&
              supportedLocales.countryCode == locale.countryCode) {
            return supportedLocales;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
