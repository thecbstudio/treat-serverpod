import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'client.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initializeClient();
  runApp(const TreatApp());
}

class TreatApp extends StatelessWidget {
  const TreatApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'treat',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    routerConfig: router,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
