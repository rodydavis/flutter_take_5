import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'src/classes/settings.dart';
import 'ui/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings _settings;

  @override
  void initState() {
    _settings = Settings();
    _settings.init();
    super.initState();
  }

  @override
  void dispose() {
    _settings?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MultiProvider(
      providers: [
        Provider<Settings>.value(value: _settings),
      ],
      child: StreamBuilder<Settings>(
          stream: _settings.stream,
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: _settings.isFresh,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: _settings.isDark ? ThemeMode.dark : ThemeMode.light,
              home: TabHome(),
              onGenerateTitle: (context) => I18n.of(context).title,
              locale: Locale('en', 'US'),
              localizationsDelegates: [
                i18n,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: i18n.supportedLocales,
              localeResolutionCallback: i18n.resolution(
                fallback: Locale('en', 'US'),
              ),
            );
          }),
    );
  }
}
